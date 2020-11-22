(load "~/code/aoc/load.ss")
(advent-year 19)
(advent-day 9)

(define program
  (with-input-from-file "../../input/19/9.in" parse-intcode))

(define (partA)
  (run-intcode program 1))

(define (partB)
  (run-intcode program 2))
