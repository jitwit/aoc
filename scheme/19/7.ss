(load "~/code/aoc/load.ss")
(advent-year 19)
(advent-day 7)
(load "intcode-network.sls")
(import (intcode-network))

(define program
  (parse-advent parse-intcode))

(define fuel 50)

(define-syntax define-network
  (lambda (x)
    (syntax-case x (=> <- >?)
      ((_ (A ...) ((x => y) ...) ((m <- phase) ...) (>? T) program)
       #'(let* ((A (intcode program)) ...
		(feeds (list (feed x y) ...)))
	   (send-input m phase) ...
	   (let run ()
	     (if (done? T)
		 (peek-output T)
		 (let ((feed (pop! feeds)))
		   (unless (eq? 'done (feed))
		     (set! feeds `(,@feeds ,feed)))
		   (run)))))))))

(define (day7 phase-settings program)
  (match phase-settings
    ((p h a s e)
     (define-network (A B C D E)
       ((A => B) (B => C) (C => D) (D => E) (E => A))
       ((A <- p) (B <- h) (C <- a) (D <- s) (E <- e) (A <- 0))
       (>? E)
       program))))

(define (best-configuration phases)
  (fold-right max 0 (map (lambda (phase-settings)
			   (day7 phase-settings program))
			 (permutations phases))))

(define (partA)
  (best-configuration '(0 1 2 3 4)))

(define (partB)
  (best-configuration '(5 6 7 8 9)))
