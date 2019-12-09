(include "~/code/advent/load.ss")
(advent-year 19)
(advent-day 2)

(define intcode
  (parse-advent comma-separated))

(define (solve intcode a b)
  (define M (cpu intcode))
  (M 'set-mem! 1 a)
  (M 'set-mem! 2 b)
  (run-until-halt M)
  (car (M 'mem 0)))

(define (partA)
  (solve intcode 12 2))

;; now incomplete. J solution works
