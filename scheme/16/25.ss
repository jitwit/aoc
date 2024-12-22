(load "~/code/aoc/load.ss")
(advent-year 16) (advent-day 25)
(load "assembunny.ss")

(define program
  (map (lambda (line)
	 (with-input-from-string line input))
       (parse-advent lines-raw)))

;; create stream of machine's clock output
(define (clock-signal machine)
  (run-until-clock machine)
  (s:cons (read-clock machine)
	  (clock-signal machine)))

(define (make-machine n)
  (define machine
    (assembunny program))
  (set-register! machine 'a n)
  (clock-signal machine))

(define (solution)
  (define N 8)
  (length
   (s:take-while (lambda (machine)
		   (not
		    (equal? (map (compose boolean->number odd?)
				 (iota N))
			    (s:take N machine))))
		 (s:map make-machine (s:iter 1+ 0)))))
