(optimize-level 3)
(define in
  '(8 0 17 4 1 12))

(define (solve in n)
  (define mem
    (make-fxvector n -1))
  (define curr)
  (define (previous x t)
    (cond ((fx< (fxvector-ref mem x) 0)
	   (set! curr 0)
	   (fxvector-set! mem x t))
	  (else
	   (set! curr (fx- t (fxvector-ref mem x)))
	   (fxvector-set! mem x t))))
  (for-each (lambda (j x)
	      (previous x (fx1+ j)))
	    (iota (length in))
	    in)
  (do ((i (fx1+ (length in)) (fx1+ i)))
      ((fx>= i n) curr)
    (previous curr i)))

(define (part-a)
  (solve in 2020))
(define (part-b)
  (solve in 30000000))
