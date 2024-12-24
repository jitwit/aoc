(load "~/code/aoc/load.ss")
(advent-year 24) (advent-day 23)
(define E ; edge set
  (make-hashtable string-hash string=?))
(define G ; adjacency list
  (make-hashtable string-hash string=?))
(define (connected? u v)
  (hashtable-ref E (string-append u v) #f))
(define (adjacent u)
  (hashtable-ref G u '()))

(define (init)
  (for-each (lambda (line)
	      (match (string-split line "-")
		((source target)
		 (hashtable-set! E (string-append source target) #t)
		 (hashtable-set! E (string-append target source) #t)
		 (hashtable-set! G source
				 (cons target (hashtable-ref G source '())))
		 (hashtable-set! G target
				 (cons source (hashtable-ref G target '()))))))
	    (parse-advent lines-raw)))

(init)

(define (part-a)
  (define T (make-hashtable equal-hash equal?))
  (for-each
   (lambda (a)
     (for-each
      (lambda (b)
	(for-each
	 (lambda (c)
	   (when (connected? c a)
	     (hashtable-set! T (sort string<? (list a b c)) #t)))
	 (adjacent b)))
      (adjacent a)))
   (filter (curry string-prefix? "t")
	   (vector->list (hashtable-keys G))))
  (vector-length (hashtable-keys T)))

(define (expand-clique c)
  (for-each (lambda (v)
	      (when (andmap (curry connected? v) c)
		(push! v c)))
	    (adjacent (car c)))
  c)

(define (part-b)
  (string-join
   (sort string<?
	 (cdr (maximum-on (map (compose expand-clique list)
			       (vector->list (hashtable-keys G)))
			  length)))
   ","))

(define (solve)
  (solve-advent part-a part-b))
