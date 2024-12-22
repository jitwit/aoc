(load "~/code/aoc/load.ss")
(advent-year 16) (advent-day 23)
(load "assembunny.ss")

(define program
  (map (lambda (line)
	 (with-input-from-string line input))
       (parse-advent lines-raw)))

(define (part-a)
  (define machine
    (assembunny program))
  (set-register! machine 'a 7)
  (run-until-halt machine)
  (get-register machine 'a))

(define (part-b v)
  (define machine
    (assembunny program))
  (set-register! machine 'a v)
  (run-until-halt machine)
  (get-register machine 'a))

