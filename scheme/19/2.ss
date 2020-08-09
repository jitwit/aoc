(load "~/code/aoc/load.ss")
;; (load "intcode.sls")
;;(advent-year 19)
;;(advent-day 2)

(define program
  (with-input-from-file "../../input/19/2.in" parse-intcode))

(define p15
  (with-input-from-file "../../input/19/15.in" parse-intcode))

(define (run2 program a b)
  (define M (intcode program))
  (intcode-set! M 1 a)
  (intcode-set! M 2 b)
  (run-until-halt M)
  (intcode-ref M 0))

(define (partA)
  (run2 program 12 2))

(define (runit x y)
  (run2 program x y))

(define (slowB)
  (- 10000
     (length
      (memq 19690720
	    (apply append
		   (vector->list
		    (vector-map vector->list
				(matrix-tabulate (matrix 100 100)
						 (lambda (x y z) (runit x y))))))))))


;; now incomplete. J solution works
