(load "~/code/aoc/load.ss")
(import (juniper))
(advent-year 16) (advent-day 14)
(define salt
  (car (parse-advent lines-raw)))
(define (md5 msg)
  (j-eval (format "15 (128!:6) '~a'" msg)))
