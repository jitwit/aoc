(load "~/code/aoc/load.ss")
(advent-year 23) (advent-day 08)
(define in
  (parse-advent lines-raw; "08.eg"
		))
(define navigation
  (map (compose string->symbol string)
       (string->list (car in))))
(define (parse-node line)
  (with-input-from-string line input))
(define network
  (let ((G (make-hashtable string-hash string=?)))
    (for-each (lambda (l)
		(match (parse-node l)
		  (`(,v = (,l (unquote ,r)))
		   (hashtable-set! G
				   (symbol->string v)
				   (cons (symbol->string l) (symbol->string r))))))
	      (list-tail in 2))
    G))

(define (search start)
  (let lp ((instructions (s:cycle navigation))
	   (node start)
	   (n 0))
    (if (eqv? (string-ref node 2) #\Z)
	n
	(let ((nodes (hashtable-ref network node #f)))
	  (lp (s:cdr instructions)
	      (match (car instructions)
		('L (car nodes))
		('R (cdr nodes)))
	      (1+ n))))))

(define (part-a)
  (search "AAA"))

(define (part-b)
  (apply lcm
	 (filter-map (lambda (node)
		       (and (eqv? #\A (string-ref node 2))
			    (search node)))
		     (vector->list (hashtable-keys network)))))
