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

(define (part-a)
  (define T '())
  (init)
  (for-each
   (lambda (a)
     (for-each
      (lambda (b)
	(for-each
	 (lambda (c)
	   (when (connected? c a)
	     (push! (sort string<? (list a b c)) T)))
	 (adjacent b)))
      (adjacent a)))
   (filter (curry string-prefix? "t")
	   (vector->list (hashtable-keys G))))
  (length (nub-equal T)))

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
