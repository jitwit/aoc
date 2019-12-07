(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 7)

(define intcode
  (parse-advent comma-separated))

;; allow N to step out of no-in lock and aggressively run M
(define (feed M N)
  (lambda ()
    (let run ()
      (case (M 'status)
        ((out) (N 'in (M 'out)) (N 'step) (M 'step) (run))
        ((no-in) 'blocked)
        ((done) 'done)
        (else (M 'step) (run))))))

(define-syntax define-network
  (syntax-rules (=> <-)
    ((_ (A ...) ((x => y) ...) ((m <- seed) ...) (->? T) intcode)
     (let ((A (machine intcode 0)) ...)
       (let ((machines (list A ...))
             (loop (list (feed x y) ...)))
         (m 'in seed) ...
         (let run ()
           (if (eq? 'done (T 'status))
               (T 'dump)
               (let ((action (pop! loop)))
                 (let ((result (action)))
                   (unless (eq? result 'done)
                     (set! loop `(,@loop ,action)))
                   (run))))))))))

(define (day7 phase-settings intcode)
  (let-values (((a b c d e) (apply values phase-settings)))
    (define-network (A B C D E)
      ((A => B) (B => C) (C => D) (D => E) (E => A))
      ((A <- a) (B <- b) (C <- c) (D <- d) (E <- e) (A <- 0))
      (->? E) intcode)))

(define (best-configuration phases)
  (define best 0)
  (for-all (lambda (phase-settings)
             (let ((out (day7 phase-settings intcode)))
               (when (< best (car out))
                 (set! best (max best (car out))))))
           (permutations phases))
  best)

(define (partA)
  (best-configuration '(0 1 2 3 4)))

(define (partB)
  (best-configuration '(5 6 7 8 9)))
