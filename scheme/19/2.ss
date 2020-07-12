(load "~/code/aoc/load.ss")
(advent-year 19)
(advent-day 2)

(define program
  (with-input-from-file (advent-file) parse-intcode))

(define (solve program a b)
  (define M (intcode program))
  (intcode-set! M 1 a)
  (intcode-set! M 2 a)
  (run-until-halt M)
  (intcode-ref M 0))

(define (partA)
  (solve intcode 12 2))

;; now incomplete. J solution works
