(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 9)

(define eg '(109 1 204 -1 1001 100 1 100 1008 100 16 101 1006 101 0 99))
(define eg2 '(1102 34915192 34915192 7 4 7 99 0))

(define intcode
  (parse-advent comma-separated))

(define (solve intcode seed)
  (define M (cpu intcode))
  (M 'in seed)
  (run-until-halt M)
  (M 'out))

(define (partA)
  (solve intcode 1))

(define (partB)
  (solve intcode 2))
