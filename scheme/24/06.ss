(load "~/code/aoc/load.ss")
(advent-year 24) (advent-day 06)
(define in (parse-advent lines-raw))
;(define in (with-input-from-file "06.in" lines-raw))
(define N (length in))
(define G (matrix N N))
(define z0)
(matrix-tabulate! G
		  (lambda (i j _)
		    (match (string-ref (list-ref in i) j)
		      (#\# #t)
		      (#\^ (set! z0 (+ i (* 0+i j))) #f)
		      (_ #f))))

(define (run dz G)
  (define S (make-eqv-hashtable))
  (define T (make-hashtable equal-hash equal?))
  (let step ((z z0) (dz dz))
    (hashtable-set! T (cons z dz) #t)
    (hashtable-set! S z #t)
    (let ((u (+ z dz)))
      (cond ((not (and (<= 0 (real-part u) (1- N))
		       (<= 0 (imag-part u) (1- N))))
	     S)
	    ((matrix-ref G (real-part u) (imag-part u))
	     (if (hashtable-ref T (cons z (* dz 0-i)) #f)
		 'cycle-detected
		 (step z (* dz 0-i))))
	    (else (step u dz))))))

(define (part-a)
  (vector-length (hashtable-keys (run -1 G))))

(define (part-b)
  ;; only need to check adding walls to squares on original path
  (length
   (filter (lambda (z)
	     (and (not (eqv? z z0))
		  (begin
		    (matrix-set! G (real-part z) (imag-part z) #t)
		    (let ((cycle? (eq? 'cycle-detected (run -1 G))))
		      (matrix-set! G (real-part z) (imag-part z) #f)
		      cycle?))))
	   (vector->list (hashtable-keys (run -1 G))))))
