(include "~/code/advent/load.ss")
(advent-year 15)
(advent-day 7)

(define (signal cell)
  (cell 'signal))

(define (propagate thunks)
  (for-all (lambda (thunk)
             (thunk))
           thunks))

(define (feed cell signal)
  ((cell 'set-signal!) signal))

(define (add-connection cell thunk)
  ((cell 'connect) thunk))

(define (make-cell)
  (let ((signal #f)
        (neighbors '()))
    (define (set-signal! x)
      (unless (eqv? x signal)
        (set! signal x)
        (propagate neighbors)))
    (define (connect neighbor)
      (unless (memv neighbor neighbors)
        (set! neighbors (cons neighbor neighbors))
        (propagate neighbors)))
    (define (reset!)
      (set! signal #f))
    (define (me m)
      (case m
        ((signal) signal)
        ((set-signal!) set-signal!)
        ((connect) connect)
        ((reset!) reset!)
        ((fires) fires)
        (else (error 'cell "I DON'T KNOW" m))))
    me))

(define (connection f cell-x cell-y cell-z)
  (define (connect)
    (let ((x (signal cell-x))
          (y (signal cell-y)))
      (when (and x y)
        (feed cell-z (f x y)))))
  (cond ((number? cell-x)
         (simple-connector (lambda (y)
                             (f cell-x y))
                           cell-y
                           cell-z))
        ((number? cell-y)
         (simple-connector (lambda (x)
                             (f x cell-y))
                           cell-x
                           cell-z))
        (else
         (add-connection cell-x connect)
         (add-connection cell-y connect)
         connect)))

(define (simple-connector f cell-x cell-z)
  (define (connect)
    (let ((x (signal cell-x)))
      (when x
        (feed cell-z (f x)))))
  (cond ((number? cell-x) (feed cell-z (f cell-x)))
        (else (add-connection cell-x connect) connect)))

(define (get-wires network)
  (nub-eq (filter (lambda (x)
                    (not (or (number? x)
                             (memq x '(-> AND OR NOT LSHIFT RSHIFT)))))
                  (apply append network))))

(define (mask x)
  (fxlogand x (fx1- (fxsll 1 16))))

(define-syntax wired
  (syntax-rules (-> AND OR NOT LSHIFT RSHIFT)
    ((_ (x AND y -> z)) (connection fxlogand x y z))
    ((_ (x OR y -> z)) (connection fxlogor x y z))
    ((_ (NOT y -> z)) (simple-connector (compose mask fxlognot) y z))
    ((_ (x RSHIFT s -> z)) (connection fxsrl x s z))
    ((_ (x LSHIFT s -> z)) (connection fxsll x s z))
    ((_ (x -> z)) (simple-connector (lambda (a) a) x z))))

(define (compile-network)
  (let ((network (parse-advent lines)))
    (eval
     `(begin
        ,@(map (lambda (wire)
                 `(define ,wire (make-cell)))
               (get-wires network))
        ,@(map (lambda (decl)
                 `(wired ,decl))
               network)))))

(define (run)
  (compile-network)
  (display-ln
   (signal a))

  (feed b (signal a))
  (display-ln
   (signal a)))
