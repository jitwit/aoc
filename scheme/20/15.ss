(optimize-level 3)
(define start
  '(8 0 17 4 1 12))

(define (solve start n)
  (define mem
    (make-fxvector n 0))
  (for-each (lambda (j)
	      (fxvector-set! mem (list-ref start j) (fx1+ j)))
	    (iota (length start)))
  (let lp ((t (length start)) (curr (car (last-pair start))))
    (cond ((fx>= t n) curr)
	  ((fxzero? (fxvector-ref mem curr))
	   (fxvector-set! mem curr t)
	   (lp (fx1+ t) 0))
	  (else
	   (let ((next (fx- t (fxvector-ref mem curr))))
	     (fxvector-set! mem curr t)
	     (lp (fx1+ t) next))))))

(define (part-a)
  (solve start 2020))
(define (part-b)
  (solve start 30000000))
