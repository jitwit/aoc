(load "~/code/aoc/load.ss")
(advent-year 19)
(advent-day 9)

(define program
  (parse-advent comma-separated))

(define (partA)
  (run-intcode program 1))

(define (partB)
  (run-intcode program 2))
