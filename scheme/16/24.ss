(load "~/code/aoc/load.ss")
(advent-year 16) (advent-day 24)

(define hvac
  (list->vector
   (map (compose list->vector string->list)
	(parse-advent lines-raw ;; "small.in"
		      ))))

(define R (vector-length hvac))
(define C (vector-length (vector-ref hvac 0)))
(define V '())

(define (adjacent v)
  (filter (lambda (u)
	    (and (<= 0 (imag-part u) (1- C))
		 (<= 0 (real-part u) (1- R))
		 (not (eqv? #\# (matrix-ref hvac u)))))
	  (nesw v)))

(define (init)
  (do ((i 0 (1+ i)))
      ((= i R))
    (do ((j 0 (1+ j)))
	((= j C))
      (let ((x (matrix-ref hvac (complex i j))))
	(when (memv x (string->list "0123456789"))
	  (push! (cons x (complex i j)) V))))))

(define (solve)
  (define T
    (begin
      (init)
      (map (lambda (x.z)
	     (cons (cdr x.z)
		   (bfs (cdr x.z) adjacent)))
	   V)))
  (define start (cdr (assv #\0 V)))
  (define vertices (remv start (map cdr V)))
  (define best +inf.0)
  (define (dist u v)
    (let ((table (bfs-result-distances (cdr (assv u T)))))
      (hashtable-ref table v +inf.0)))
  (define (try-path vs d)
    (match vs
      ((u v vs ...) (try-path (cons v vs) (+ d (dist u v))))
      (_ (when (< d best) (set! best d)))))
  (for-each (lambda (vs)
	      (try-path (cons start vs) 0))
	    (permutations vertices))
  (format #t "part a: ~a~%" best)
  (set! best +inf.0)
  (for-each (lambda (vs)
	      (try-path `(,start ,@vs ,start) 0))
	    (permutations vertices))
  (format #t "part b: ~a~%" best))
