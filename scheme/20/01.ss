(optimize-level 3)
(load "~/code/aoc/load.ss")
(advent-year 20) (advent-day 1)

(define expenses
  (list->vector (parse-advent input)))

(define (partA)
  (call/cc
   (lambda (k)
     (algorithm-T (vector-length expenses)
		  2
		  (lambda (C)
		    (let ((x (vector-ref expenses (fxvector-ref C 1)))
			  (y (vector-ref expenses (fxvector-ref C 2))))
		      (when (= 2020 (+ x y))
			(k (* x y)))))))))

(define (partB)
  (call/cc
   (lambda (k)
     (algorithm-T (vector-length expenses)
		  3
		  (lambda (C)
		    (let ((x (vector-ref expenses (fxvector-ref C 1)))
			  (y (vector-ref expenses (fxvector-ref C 2)))
			  (z (vector-ref expenses (fxvector-ref C 3))))
		      (when (= 2020 (+ x y z))
			(k (* x y z)))))))))
