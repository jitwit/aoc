(load "~/code/aoc/load.ss")
(advent-year 16) (advent-day 25)
(load "assembunny.ss")

(define program
  (map (lambda (line)
	 (with-input-from-string line input))
       (parse-advent lines-raw)))

;; create stream of machine's clock output
(define (clock-signal n)
  (define machine
    (assembunny program))
  (set-register! machine 'a n)
  (let lp ()
    (run-until-clock machine)
    (s:cons (read-clock machine)
	    (lp))))

(define (solution)
  (define N 8)
  (define P (map (compose boolean->number odd?) (iota N)))
  (length
   (s:take-while (lambda (signals)
		   (not (equal? P (s:take N signals))))
		 (s:map clock-signal (s:iter 1+ 0)))))
