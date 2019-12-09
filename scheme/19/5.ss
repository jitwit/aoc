(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 5)

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
  (solve intcode 5))
