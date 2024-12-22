(load "~/code/aoc/load.ss")
(load "assembunny.ss")
(advent-year 16) (advent-day 12)

(define program
  (map (lambda (line)
	 (with-input-from-string line input))
       (parse-advent lines-raw)))

(define (part-a)
  (define machine
    (assembunny program))
  (run-until-halt machine)
  (get-register machine 'a))

(define (part-b)
  (define machine
    (assembunny program))
  (set-register! machine 'c 1)
  (run-until-halt machine)
  (get-register machine 'a))
