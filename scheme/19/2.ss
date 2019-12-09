(include "~/code/advent/load.ss")
(advent-year 19)
(advent-day 2)

(define (solve intcode a b)
  (define M (cpu `(,(car intcode) ,a ,b ,@(list-tail intcode 3))))
  (run-until-halt M)
  (M 'mem))

;; now incomplete. J solution works
