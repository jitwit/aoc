(load "~/code/aoc/load.ss")
(advent-year 19)
(advent-day 5)

(define program
  (with-input-from-file (advent-file) parse-intcode))

(define (partA)
  (run-intcode program 1))

(define (partB)
  (run-intcode program 5))
