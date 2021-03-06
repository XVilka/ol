(define-library (lang primop)

(export
      verbose-vm-error primop-of primitive?
      primop-name ;; primop → symbol | primop
      special-bind-primop? variable-input-arity?
      multiple-return-variable-primop? opcode-arity-ok? opcode-arity-ok-2?
      )

   (import
      (r5rs core)
      (owl list) (owl ff) (owl math)
      (src vm))

   (begin

      ;; ff of opcode → wrapper
      (define prim-opcodes ;; ff of wrapper-fn → opcode
         (for empty primops
            (λ (ff node)
               (put ff (ref node 5) (ref node 2)))))
;      (define opcode->wrapper
;         (for empty primops
;            (λ (ff node)
;               (put ff (ref node 2) (ref node 5)))))

      ;; later check type, get first opcode and compare to primop wrapper
      (define (primop-of val)
         (get prim-opcodes val #false))


      (define primitive? primop-of)

      ;; non-primop instructions that can report errors
      (define (instruction-name op)
         (cond
            ((eq? op 17) 'arity-error)
            (else #false)))

      ; используется в выводе сообщений "инструкция такая-то сфейлила"
      (define (primop-name pop)
         (let ((pop (vm:and pop #x3F))) ; ignore top bits which sometimes have further data
            (or
               (instruction-name pop)
               (let loop ((primops primops))
                  (cond
                     ((null? primops) pop)
                     ((eq? pop (ref (car primops) 2))
                        (ref (car primops) 1))
                     (else
                        (loop (cdr primops))))))))

      ;; from cps
      (define (special-bind-primop? op) ; tuple-apply and ff-apply
         (has? special-bind-primops op))

      (define (variable-input-arity? op)
         (has? variable-input-arity-primops op))

      (define (multiple-return-variable-primop? op)
         (has? multiple-return-variable-primops op))

      ;; primops = (#(name opcode in-args|#f out-args|#f wrapper-fn|#f) ...)

      ;; ff of opcode → (in|#f out|#f), #f if variable
      (define primop-arities
         (fold
            (λ (ff node)
               (lets ((name op in out wrapper node))
                  (put ff op (cons in out))))
            empty primops))

      (define (opcode-arity-ok? op in out)
         (let ((node (getf primop-arities op)))
            (if node
               (and
                  (or (eq? in  (car node)) (not (car node)))
                  (or (eq? out (cdr node)) (not (cdr node))))
               #true)))

      ;; fixme: ??? O(n) search for opcode->primop. what the...
      (define (opcode->primop op)
         (let
            ((node
               (some
                  (λ (x) (if (eq? (ref x 2) op) x #false))
                  primops)))
            (if node node (runtime-error "Unknown primop: " op))))

      (define (opcode-arity-ok-2? op n)
         (tuple-apply (opcode->primop op)
            (λ (name op in out fn)
               (cond
                  ((eq? in n) #true)
                  ((eq? in 'any) #true)
                  (else #false)))))


      (define (verbose-vm-error opcode a b)
         (cons "error: "
         (if (eq? opcode ARITY-ERROR)  ;; arity error, could be variable
               ; this is either a call, in which case it has an implicit continuation,
               ; or a return from a function which doesn't have it. it's usually a call,
               ; so -1 to not count continuation. there is no way to differentiate the
               ; two, since there are no calls and returns, just jumps.
            `(function ,a got did not want ,(- b 1) arguments)
         (if (eq? opcode CAR)
            `(trying to get car of a non-pair ,a)
         (if (eq? opcode CDR)
            `(trying to get cdr of a non-pair ,a)
         `(,(primop-name opcode) reported error ": " ,a " " ,b)
         )))))
         ;   ;((eq? opcode 52)
         ;   ;   `(trying to get car of a non-pair ,a))
         ;   (else
         ;      `("error: instruction" ,(primop-name opcode) "reported error: " ,a " " ,b)))


))
