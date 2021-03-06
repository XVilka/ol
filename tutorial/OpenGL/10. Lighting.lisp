#!/usr/bin/ol
(define *include-dirs* (cons "../.." *include-dirs*))
(import (lib opengl))

;(teapot)
(define vertices '(
    (  0.2000  0.0000 2.70000 ) (  0.2000 -0.1120 2.70000 )
    (  0.1120 -0.2000 2.70000 ) (  0.0000 -0.2000 2.70000 )
    (  1.3375  0.0000 2.53125 ) (  1.3375 -0.7490 2.53125 )
    (  0.7490 -1.3375 2.53125 ) (  0.0000 -1.3375 2.53125 )
    (  1.4375  0.0000 2.53125 ) (  1.4375 -0.8050 2.53125 )
    (  0.8050 -1.4375 2.53125 ) (  0.0000 -1.4375 2.53125 )
    (  1.5000  0.0000 2.40000 ) (  1.5000 -0.8400 2.40000 )
    (  0.8400 -1.5000 2.40000 ) (  0.0000 -1.5000 2.40000 )
    (  1.7500  0.0000 1.87500 ) (  1.7500 -0.9800 1.87500 )
    (  0.9800 -1.7500 1.87500 ) (  0.0000 -1.7500 1.87500 )
    (  2.0000  0.0000 1.35000 ) (  2.0000 -1.1200 1.35000 )
    (  1.1200 -2.0000 1.35000 ) (  0.0000 -2.0000 1.35000 )
    (  2.0000  0.0000 0.90000 ) (  2.0000 -1.1200 0.90000 )
    (  1.1200 -2.0000 0.90000 ) (  0.0000 -2.0000 0.90000 )
    ( -2.0000  0.0000 0.90000 ) (  2.0000  0.0000 0.45000 )
    (  2.0000 -1.1200 0.45000 ) (  1.1200 -2.0000 0.45000 )
    (  0.0000 -2.0000 0.45000 ) (  1.5000  0.0000 0.22500 )
    (  1.5000 -0.8400 0.22500 ) (  0.8400 -1.5000 0.22500 )
    (  0.0000 -1.5000 0.22500 ) (  1.5000  0.0000 0.15000 )
    (  1.5000 -0.8400 0.15000 ) (  0.8400 -1.5000 0.15000 )
    (  0.0000 -1.5000 0.15000 ) ( -1.6000  0.0000 2.02500 )
    ( -1.6000 -0.3000 2.02500 ) ( -1.5000 -0.3000 2.25000 )
    ( -1.5000  0.0000 2.25000 ) ( -2.3000  0.0000 2.02500 )
    ( -2.3000 -0.3000 2.02500 ) ( -2.5000 -0.3000 2.25000 )
    ( -2.5000  0.0000 2.25000 ) ( -2.7000  0.0000 2.02500 )
    ( -2.7000 -0.3000 2.02500 ) ( -3.0000 -0.3000 2.25000 )
    ( -3.0000  0.0000 2.25000 ) ( -2.7000  0.0000 1.80000 )
    ( -2.7000 -0.3000 1.80000 ) ( -3.0000 -0.3000 1.80000 )
    ( -3.0000  0.0000 1.80000 ) ( -2.7000  0.0000 1.57500 )
    ( -2.7000 -0.3000 1.57500 ) ( -3.0000 -0.3000 1.35000 )
    ( -3.0000  0.0000 1.35000 ) ( -2.5000  0.0000 1.12500 )
    ( -2.5000 -0.3000 1.12500 ) ( -2.6500 -0.3000 0.93750 )
    ( -2.6500  0.0000 0.93750 ) ( -2.0000 -0.3000 0.90000 )
    ( -1.9000 -0.3000 0.60000 ) ( -1.9000  0.0000 0.60000 )
    (  1.7000  0.0000 1.42500 ) (  1.7000 -0.6600 1.42500 )
    (  1.7000 -0.6600 0.60000 ) (  1.7000  0.0000 0.60000 )
    (  2.6000  0.0000 1.42500 ) (  2.6000 -0.6600 1.42500 )
    (  3.1000 -0.6600 0.82500 ) (  3.1000  0.0000 0.82500 )
    (  2.3000  0.0000 2.10000 ) (  2.3000 -0.2500 2.10000 )
    (  2.4000 -0.2500 2.02500 ) (  2.4000  0.0000 2.02500 )
    (  2.7000  0.0000 2.40000 ) (  2.7000 -0.2500 2.40000 )
    (  3.3000 -0.2500 2.40000 ) (  3.3000  0.0000 2.40000 )
    (  2.8000  0.0000 2.47500 ) (  2.8000 -0.2500 2.47500 )
    (  3.5250 -0.2500 2.49375 ) (  3.5250  0.0000 2.49375 )
    (  2.9000  0.0000 2.47500 ) (  2.9000 -0.1500 2.47500 )
    (  3.4500 -0.1500 2.51250 ) (  3.4500  0.0000 2.51250 )
    (  2.8000  0.0000 2.40000 ) (  2.8000 -0.1500 2.40000 )
    (  3.2000 -0.1500 2.40000 ) (  3.2000  0.0000 2.40000 )
    (  0.0000  0.0000 3.15000 ) (  0.8000  0.0000 3.15000 )
    (  0.8000 -0.4500 3.15000 ) (  0.4500 -0.8000 3.15000 )
    (  0.0000 -0.8000 3.15000 ) (  0.0000  0.0000 2.85000 )
    (  1.4000  0.0000 2.40000 ) (  1.4000 -0.7840 2.40000 )
    (  0.7840 -1.4000 2.40000 ) (  0.0000 -1.4000 2.40000 )
    (  0.4000  0.0000 2.55000 ) (  0.4000 -0.2240 2.55000 )
    (  0.2240 -0.4000 2.55000 ) (  0.0000 -0.4000 2.55000 )
    (  1.3000  0.0000 2.55000 ) (  1.3000 -0.7280 2.55000 )
    (  0.7280 -1.3000 2.55000 ) (  0.0000 -1.3000 2.55000 )
    (  1.3000  0.0000 2.40000 ) (  1.3000 -0.7280 2.40000 )
    (  0.7280 -1.3000 2.40000 ) (  0.0000 -1.3000 2.40000 )
    (  0       0      0)
    (  1.425  -0.798  0)
    (  1.5     0      0.075)  ;  / * 120 * /
    (  1.425   0      0)
    (  0.798  -1.425  0)
    (  0      -1.5    0.075)
    (  0      -1.425  0)
    (  1.5    -0.84   0.075)
    (  0.84   -1.5    0.075) ; / * 126 * /

))

(define (nth list n)
   (if (= n 0) (car list)
               (nth (cdr list) (- n 1))))

(define Lid: '(
    ( ( 96  96  96  96)  ( 97  98  99 100)
      (101 101 101 101)  (  0   1   2   3) )
    ( (  0   1   2   3)  (106 107 108 109)
      (110 111 112 113)  (114 115 116 117) )))
(define Rim: '(
    ( (102 103 104 105)  (  4   5   6   7)
      (  8   9  10  11)  ( 12  13  14  15) )))
(define Body: '(
    ( ( 12  13  14  15)  ( 16  17  18  19)
      ( 20  21  22  23)  ( 24  25  26  27) )
    ( ( 24  25  26  27)  ( 29  30  31  32)
      ( 33  34  35  36)  ( 37  38  39  40) )))
(define Bottom: '(
    ( (118 118 118 118)  (124 122 119 121)
      (123 126 125 120)  ( 40  39  38  37) )))

(define Handle: '(
    ( ( 41  42  43  44)  ( 45  46  47  48)
      ( 49  50  51  52)  ( 53  54  55  56) )
    ( ( 53  54  55  56)  ( 57  58  59  60)
      ( 61  62  63  64)  ( 28  65  66  67) )))
(define Spout: '(
    ( ( 68  69  70  71)  ( 72  73  74  75)
      ( 76  77  78  79)  ( 80  81  82  83) )
    ( ( 80  81  82  83)  ( 84  85  86  87)
      ( 88  89  90  91)  ( 92  93  94  95) )))


(define knots '(0 0 0 0 1 1 1 1))


(gl:run

   "6. Teapot"

; init
(lambda ()
   (glShadeModel GL_SMOOTH)
   (glClearColor 0.11 0.11 0.11 1)

   (glMatrixMode GL_PROJECTION)
   (glLoadIdentity)
   (gluPerspective 45 (/ 640 480) 0.1 100)

   (glEnable GL_DEPTH_TEST)

   ; http://www.glprogramming.com/red/chapter12.html
   (glEnable GL_LIGHTING)
   (glLightModelf GL_LIGHT_MODEL_TWO_SIDE GL_TRUE)
   (glEnable GL_NORMALIZE)


   (glEnable GL_LIGHT0)
   (glLightfv GL_LIGHT0 GL_DIFFUSE '(0.7 0.7 0.2))

   (let ((teapot (gluNewNurbsRenderer)))
      (gluNurbsProperty teapot GLU_DISPLAY_MODE GLU_FILL)
;      (gluNurbsProperty teapot GLU_DISPLAY_MODE GLU_OUTLINE_POLYGON)
;      (gluNurbsProperty teapot GLU_DISPLAY_MODE GLU_OUTLINE_PATCH)
   (let ((sphere (gluNewQuadric)))
      (gluQuadricDrawStyle sphere GLU_FILL)
      (gluQuadricOrientation sphere GLU_OUTSIDE)

   #|
   (glNewList 1 GL_COMPILE)
   (let ((render (lambda (surface)
                     (let ((points (foldr append '() (map (lambda (n) (nth vertices n)) surface))))
                        (gluBeginSurface teapot)
                        ;(gluNurbsSurface teapot 8 knots 8 knots (* 4 3) 3  points  4 4 GL_MAP2_NORMAL)
                        (gluNurbsSurface teapot 8 knots 8 knots (* 4 3) 3  points  4 4 GL_MAP2_VERTEX_3)
                        (gluEndSurface teapot)))))
   (let ((CW  (lambda (surface)
                 (for-each (lambda (lines) (render (foldr append '() (reverse lines)))) surface)))
         (CCW (lambda (surface)
                 (for-each (lambda (lines) (render (foldr append '()          lines ))) surface))))
      (CCW Handle:)
      (CCW Spout:)
      (glScalef 1 -1 1)
      (CW  Handle:)
      (CW  Spout:)
      (glScalef 1 -1 1)

      (let loop ((n 4))
         (CCW Lid:)
         (CCW Rim:)
         (CCW Body:)
         (CCW Bottom:)

         (glRotatef 90  0 0 1)
         (if (> n 1)
            (loop (- n 1))))
   ))
   (glEndList)
   |#


   (list 3 0.02 -8 0.02  teapot sphere))))

; draw
(lambda (x   dx y   dy  teapot sphere)
   (glClear (vm:or GL_COLOR_BUFFER_BIT GL_DEPTH_BUFFER_BIT))

   (glMatrixMode GL_MODELVIEW)
   (glLoadIdentity)
   (gluLookAt x y 5
      0 0 3
      0 0 1)

   (glEnable GL_LIGHTING)
   (glLightfv GL_LIGHT0 GL_POSITION (list 7 (- 3) 3.0 0.0))

   ; draw teapot
   ; http://www.wakayama-u.ac.jp/~wuhy/GSS/10.html
   (glPushMatrix)
   (glEnable GL_AUTO_NORMAL)

;   (glCallList 1)
;   (glEnable GL_CULL_FACE)
;   (glCullFace GL_BACK)
   (let ((render (lambda (surface)
                     (let ((points (foldr append '() (map (lambda (n) (nth vertices n)) surface))))
                        (gluBeginSurface teapot)
                        ;(gluNurbsSurface teapot 8 knots 8 knots (* 4 3) 3  points  4 4 GL_MAP2_NORMAL)
                        (gluNurbsSurface teapot 8 knots 8 knots (* 4 3) 3  points  4 4 GL_MAP2_VERTEX_3)
                        (gluEndSurface teapot)))))
   (let ((CW  (lambda (surface)
                 (for-each (lambda (lines) (render (foldr append '() (reverse lines)))) surface)))
         (CCW (lambda (surface)
                 (for-each (lambda (lines) (render (foldr append '()          lines ))) surface))))
      (CCW Handle:)
      (CCW Spout:)
      (glScalef 1 -1 1)
      (CW  Handle:)
      (CW  Spout:)
      (glScalef 1 -1 1)

      (let loop ((n 4))
         (CCW Lid:)
         (CCW Rim:)
         (CCW Body:)
         (CCW Bottom:)

         (glRotatef 90  0 0 1)
         (if (> n 1)
            (loop (- n 1))))
   ))
   (glPopMatrix)

;   (glDisable GL_LIGHTING)
;   (glPointSize 4.0)
;   (glBegin GL_POINTS)
;   (glColor3f 1.0 0.0 0.0)
;      (for-each
;         (lambda (n)
;            (glVertex3fv (nth vertices n)))
;         (list
;            (nth (car Body:) 12)
;            (nth (car Body:) 13)
;            (nth (car Body:) 14)
;            (nth (car Body:) 15)))
;   (glEnd)

   (glTranslatef -2 4 5)
   (gluSphere sphere 1 16 8)

   (let ((nx (if (or (> x 7) (< x -7)) (- dx) dx))
         (ny (if (or (> y 9) (< y -9)) (- dy) dy)))
      (list (+ x nx) nx (+ y ny) ny teapot sphere))
))
