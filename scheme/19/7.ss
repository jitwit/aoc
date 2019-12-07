(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 7)

(define intcode
  (parse-advent comma-separated))

(define-syntax define-network
  (syntax-rules (=> <-)
    ((_ (A ...) ((x => y) ...) ((m <- seed) ...) (->? T) intcode)
     (let ((A (machine intcode 0)) ...)
       (let ((machines (list A ...))
             (loop (list (feed x y) ...)))
         (m 'in seed) ...
         (let run ()
           (if (eq? 'done (T 'status))
               (T 'out)
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
               (when (< best out)
                 (set! best (max best out)))))
           (permutations phases))
  best)

(define (partA)
  (best-configuration '(0 1 2 3 4)))

(define (partB)
  (best-configuration '(5 6 7 8 9)))
