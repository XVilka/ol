; алгоритм проверки виден ли угол из центра некоторого кубика
; todo: оформить библиотекой

; can be organized as set-car!
(fork-server 'IDs (lambda ()
(let this ((id 1))
(let* ((envelope (wait-mail))
       (sender msg envelope))
   (mail sender id)
   (this (+ id 1))))))
(define (generate-unique-id)
   (interact 'IDs 0))
   

;(fork-server 'creatures (lambda ()
;(let this ((all #empty))
;(let* ((envelope (wait-mail))
;       (sender msg envelope))
;   (tuple-case msg
;      ((add creature)
;         (let ((id (interact 'ids))))
;            (mail sender id)
;            (this (put all id creature)))
;      ((get id)
;         (mail sender (get all id #false))
;         (this all))
;      ((die id)
;      (else
;         (this all)))))))



(define (>= a b)
  (or (> a b) (= a b)))
(define (frac x) (- x (floor x)))
;(define (cfrac x) (- (ceil x) x))

; ---------------------------------------------------------------------------
; assert (start point is free)
(define (horizontal-bresenham x1 y1  x2 y2  dk)
; assert обе точки не внутри стен
; Проверка более горизонтальных чем вертикальных линий
; 1. выровнять стартовую (слева) точку вправо
; 3. проверить первый куб (слева от стартовой) (через индикатор y = -1)
; 4. в цикле проверять правый куб для точки (и левый, если перешли через координатную прямую - по у)
(let* ((x (+ 1 (floor x1)))
       (y (+ y1 (* (- x x1) dk))))
(let loop ((x x) (y y) (oldy -1)  (n (- (ceil x2) x)))
   (if (= n 0)
      #t
   (if (and 
          (not (= y oldy)) ; если пересекли линию стен
          (> (at (- x 1) (floor y)) 0))
      #f
   (if (> (at x (floor y)) 0)
      #f
   (loop (+ x 1) (+ y dk) y (- n 1))))))))
      

(define (vertical-bresenham x1 y1  x2 y2  dk)
(let* ((y (+ 1 (floor y1)))
       (x (+ x1 (* (- y y1) dk))))
(let loop ((x x) (y y) (oldx -1)  (n (- (ceil y2) y)))
   (if (= n 0)
      #t
   (if (and 
          (not (= x oldx)) ; если пересекли линию стен
          (> (at (floor x) (- y 1)) 0))
      #f
   (if (> (at (floor x) y) 0)
      #f
   (loop (+ x dk) (+ y 1) y (- n 1))))))))

(define (is-point-can-see-point x1 y1  x2 y2)
; подразумевается, что начальная и конечная точки НЕ в стене
;(if (and (= (floor x1) (floor x2)) (= (floor y1) (floor y2))) ; если это один и тот же блок
;   #t
(let ((dx (- x2 x1))
      (dy (- y2 y1)))
   (if (> (abs dx) (abs dy)) ; горизонтальный
      (if (> dx 0)
         (horizontal-bresenham x1 y1  x2 y2  (/ dy dx))
         (horizontal-bresenham x2 y2  x1 y1  (/ dy dx)))
      (if (> dy 0)
         (vertical-bresenham x1 y1  x2 y2  (/ dx dy))
         (vertical-bresenham x2 y2  x1 y1  (/ dx dy))))))

(define (is-visible x1 y1 x2 y2)
   (and (> x1 0) (> y1 0) (< x1 WIDTH) (< y1 HEIGHT)
        (> x2 0) (> y2 0) (< x2 WIDTH) (< y2 HEIGHT)
        (is-point-can-see-point x1 y1 x2 y2)))

; -=( get-waypoints )=-----------------------------------------------
; возвращает список вейпоинтов, видимых из данной точки карты на N клеток
(define (is-corner-rt x y) ; левый нижний угол блока?
   (and
      (= (at x y) 0)
      (> (at (- x 1) y) 0)
      (= (at (- x 1) (- y 1)) 0)
      (= (at x (- y 1)) 0)))
(define (is-corner-lt x y) ; левый нижний угол блока?
   (and
      (> (at x y) 0)
      (= (at (- x 1) y) 0)
      (= (at (- x 1) (- y 1)) 0)
      (= (at x (- y 1)) 0)))
(define (is-corner-lb x y) ; левый нижний угол блока?
   (and
      (= (at x y) 0)
      (= (at (- x 1) y) 0)
      (= (at (- x 1) (- y 1)) 0)
      (> (at x (- y 1)) 0)))
(define (is-corner-rb x y) ; левый нижний угол блока?
   (and
      (= (at x y) 0)
      (= (at (- x 1) y) 0)
      (> (at (- x 1) (- y 1)) 0)
      (= (at x (- y 1)) 0)))
      
(define (find-point-in-list list xy)
   (if (null? list)
      #f
   (if (and (= (car (car list)) (car xy))
            (= (cdr (car list)) (cdr xy)))
      #t
   (find-point-in-list (cdr list) xy))))
   
(define (add-waypoint xy list)
   (if (find-point-in-list list xy)
      list
      (cons xy list)))

(define (check-corner x y  points)
   (if (is-corner-rt x y)
      (add-waypoint (cons (+ x 0.5) y)
      (add-waypoint (cons x (- y 0.5)) points))
   (if (is-corner-lt x y)
      (add-waypoint (cons (- x 0.5) y)
      (add-waypoint (cons x (- y 0.5)) points))
   (if (is-corner-lb x y)
      (add-waypoint (cons (- x 0.5) y)
      (add-waypoint (cons x (+ y 0.5)) points))
   (if (is-corner-rb x y)
      (add-waypoint (cons (+ x 0.5) y)
      (add-waypoint (cons x (+ y 0.5)) points))
   points)))))


(define (get-waypoints me N)
; fixme: вейпоинты в списке могут дублироваться

; Осмотреться. Возвращает список вейпоинтов. 
(let lookout ((n 0) (x (floor (car me))) (y (floor (cdr me)))  (points '()))
   (if (= n N)
      points
      (let left-to-right ((x x) (y y) (i (+ n n 1))  (points points))
         (if (> i 0)
            (left-to-right (+ x 1) y (- i 1)  (if (is-visible (car me) (cdr me) x y) (check-corner x y  points) points))
      (let top-to-bottom ((x x) (y y) (i (+ n n 1))  (points points))
         (if (> i 0)
            (top-to-bottom x (+ y 1) (- i 1)  (if (is-visible (car me) (cdr me) x y) (check-corner x y  points) points))
      (let right-to-left ((x x) (y y) (i (+ n n 1))  (points points))
         (if (> i 0)
            (right-to-left (- x 1) y (- i 1)  (if (is-visible (car me) (cdr me) x y) (check-corner x y  points) points))
      (let bottom-to-top ((x x) (y y) (i (+ n n 1))  (points points))
         (if (> i 0)
            (bottom-to-top x (- y 1) (- i 1)  (if (is-visible (car me) (cdr me) x y) (check-corner x y  points) points))
      (lookout (+ n 1) (- x 1) (- y 1) points))))))))))))


;(let ((x 1.5)
;      (y 1.5))
;   (map (lambda (p)
;
;(define (fn x y element  me-x me-y)
;   (print 1)
;   (+ element 1))
;
;(let ((for-x (lambda (x y old)
;   (if (null? old)
;      null
;      (let* ((head tail map)
;             (head (fn head))) ;; compute head first
;         (cons head (for-x (+ x 1) tail)))))
;)

(define fov (repeat (repeat 0 WIDTH) HEIGHT))

(print fov)

(print
(let ((X 1.5) (Y 1.5))
(let for-y ((y 0) (lines fov))
   (if (null? lines)
      null
      (cons
         (let for-x ((x 0) (cells (car lines)))
            (if (null? cells)
               null
               (cons 
                  (let ((cell (car cells)))
                     (if (and
                           (or
                              (is-point-can-see-point X Y x y)
                              (is-point-can-see-point X Y (+ x 1) y)
                              (is-point-can-see-point X Y (+ x 1) (+ y 1))
                              (is-point-can-see-point X Y x (+ y 1)))
                           (> (at x y) 0))
                        (+ cell 1)
                        cell))
                  (for-x (+ x 1) (cdr cells)))))
         (for-y (+ y 1) (cdr lines)))))
))
;(halt 12)



;   (if (= y HEIGHT)
;      new
;      (for-x (+ y 1) (cdr map) (



;(print
;(horizontal-bresenham 1 1  4.5 3))
;(halt 0)




(define (new-creature x y)
(let* ((id (generate-unique-id))
       (creature (fork-server id (lambda ()
; x, y - положение AI
(let this ((fov (repeat (repeat 0 WIDTH) HEIGHT))
           (x 1.5)
           (y 1.5))
(let* ((envelope (wait-mail))
       (sender msg envelope))
   (tuple-case msg
      ((die)
         #false)

      ((set-location location)
         (print "creature: 'set-location " location)
         (this fov (car location) (cdr location)))
      ; создать существо

      ((get-fov)
         (mail sender fov)
         (this fov x y))
      ((get-location)
         (mail sender (cons x y))
         (this fov x y))
      ((update-fov map)
         (print "creature: 'update-fov requested")
         (let ((fov
         (let ((X x) (Y y))
         (let for-y ((y 0) (lines fov) (map-lines map))
            (if (null? lines)
               null
               (cons
                  (let for-x ((x 0) (cells (car lines)) (map-cells (car map-lines)))
                     (if (null? cells)
                        null
                        (cons 
                           (let ((cell (car cells)))
;                              (print "creature: test for " x " " y " " X " " Y)
;                              (print "creature: test for " x " " y " " X " " Y " " (cdr map-cells))
                              (if (or
                                    (is-point-can-see-point X Y x y)
                                    (is-point-can-see-point X Y (+ x 1) y)
                                    (is-point-can-see-point X Y (+ x 1) (+ y 1))
                                    (is-point-can-see-point X Y x (+ y 1)))
                                 (car map-cells)
                                 (if (> cell 0) (+ cell 1) 0)))
                           (for-x (+ x 1) (cdr cells) (cdr map-cells)))))
                  (for-y (+ y 1) (cdr lines) (cdr map-lines))))))))
         (this fov x y)))
      
      (else
         (print "'ai error: unknown command " msg)
         (this fov x y)))))))))
   (print "new creature " id " spawned.")      
   id))