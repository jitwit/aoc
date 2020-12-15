(define in
  '(8 0 17 4 1 12))

(define (solve in n)
  (define mem
    (make-eq-hashtable))
  (define curr)
  (define (previous x t)
    (let ((t* (hashtable-ref mem x t)))
      (hashtable-set! mem x t)
      (set! curr (- t t*))))
  (for-each (lambda (j x)
	      (previous x (1+ j)))
	    (iota (length in))
	    in)
  (do ((i (1+ (length in)) (1+ i)))
      ((>= i n)
       curr)
    (previous curr i)))

(define (part-a)
  (solve in 2020))
(define (part-b)
  (solve in 30000000))
