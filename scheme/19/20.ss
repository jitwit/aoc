(load "~/code/aoc/load.ss")
(advent-year 19)
(advent-day 20)

(define world-map
  (list->vector
   (map (compose list->vector string->list)
	;; (with-input-from-file "large.in" lines-raw)
	(parse-advent lines-raw)
	)))

(define (world)
  (let ((t (make-eqv-hashtable))
	(h (vector-length world-map))
	(w (vector-length (vector-ref world-map 0))))
    (do ((i 0 (1+ i)))
	((= i h) t)
      (do ((j 0 (1+ j)))
	  ((= j w))
	(match (vector-ref (vector-ref world-map i) j)
	  (#\. (hashtable-set! t (make-rectangular j i) 'open))
	  (#\space (void)) (#\# (void))
	  (x (hashtable-set! t (make-rectangular j i) x)))))))

(define (letters world)
  (filter (lambda (z.x)
	    (not (eq? 'open (cdr z.x))))
	  (vector->list (hashtable-cells world))))

(define (english-order pair)
  (match pair
    (((u . x) (v . y))
     (let ((dz (- u v)))
       (if (real? dz)
	   (if (< (real-part u) (real-part v))
	       pair
	       (reverse pair))
	   (if (< (imag-part u) (imag-part v))
	       pair
	       (reverse pair)))))))

(define (inner-edges W)
  (define es '())
  (vector-for-each (lambda (pair)
		     (match pair
		       ((z . 'open)
			(for-each (lambda (w)
				    (when (eq? 'open (hashtable-ref W w #f))
				      (push! (list w z) es)))
				  (nesw z)))
		       (_ (void))))
		   (hashtable-cells W))
  es)

(define (world-graph)
  (define W (world))
  (define ls (letters W))
  (define portals
    (map car
	 (sort (lambda (a b) (string<? (cdr a) (cdr b)))
	       (nub-equal
		(filter-map (lambda (pair)
			      (let ((pair (english-order pair)))
				(match pair
				  (((u . x) (v . y))
				   (let* ((dz (- u v))
					  (id (string x y)))
				     (and (= 1 (magnitude dz))
					  (if (hashtable-ref W (+ u dz) #f)
					      (cons (+ u dz) id)
					      (cons (- v dz) id))))))))
			    (cartesian-product (list ls ls)))))))
  (define n (length portals))
  (define G (inner-edges W))
  (match portals
    ((aa es ... zz)
     (let ((outer-edges (n-tuples 2 es)))
       (list aa zz 
	     (append outer-edges
		     (map reverse outer-edges)
		     G))))))

(define (outside? W)
  (define-values (xlo xhi ylo yhi)
    (bounding-box-C (apply append (inner-edges W))))
  (lambda (z)
    (or (memv (real-part z) (list xlo xhi))
	(memv (imag-part z) (list ylo yhi)))))

(define (solve)
  (define seen (make-eqv-hashtable))
  (define G (make-eqv-hashtable))
  (match (world-graph)
    ((aa zz edges)
     (for-each (lambda (uv)
		 (match uv
		   ((x y)
		    (hashtable-update! G x (lambda (zs) (cons y zs)) '())
		    (hashtable-update! G y (lambda (zs) (cons x zs)) '()))))
	       edges)
     (hashtable-set! seen aa 0)
     (let bfs ((Q (q:consq (cons 0 aa) q:empty)))
       (unless (q:empty? Q)
	 (match (q:headq Q)
	   ((d . z)
	    (let adj ((zs (hashtable-ref G z '())) (Q (q:tailq Q)))
	      (match zs
		((z zs ...)
		 (cond ((not (hashtable-ref seen z #f))
			(hashtable-set! seen z (1+ d))
			(adj zs (q:snocq Q (cons (1+ d) z))))
		       (else
			(adj zs Q))))
		(_ (bfs Q))))))))
     (hashtable-ref seen zz #f))))
