(load "~/code/aoc/load.ss")
(advent-year 23) (advent-day 15)
;; (with-input-from-string
;; 	   "rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7"
;; 	 comma-separated)
(define input
  (map symbol->string (parse-advent comma-separated)))
(define (hash s)
  (define (hash* n x)
    (modulo (* 17 (+ n (char->integer x))) 256))
  (fold-left hash* 0 (string->list s)))

(define (part-a)
  (apply + (map hash input)))

(define (part-b)
  (define boxes (make-vector 256 '()))
  (for-each (lambda (r)
	      (match (string-tokenize r
				      (char-set-complement (char-set #\- #\=)))
		((label focal-length)
		 (let* ((ix (hash label))
			(box (vector-ref boxes ix))
			(lens (cons label (string->number focal-length))))
		   (if (member label (map car box))
		       (vector-set! boxes
				    ix
				    (map (lambda (l)
					   (if (string=? (car l) label)
					       lens
					       l))
					 box))
		       (vector-set! boxes
				    ix
				    (cons lens box)))))
		((label)
		 (let* ((ix (hash label))
			(box (vector-ref boxes ix)))
		   (vector-set! boxes
				ix
				(filter (lambda (l)
					  (not (string=? (car l) label)))
					box))))
		(else (error 'part-b "oops"))))
	    input)
  (vector-sum
   (vector-map (lambda (i box)
		 (* (1+ i)
		    (apply +
			   (map *
				(map 1+ (iota (length box)))
				(map cdr (reverse box))))))
	       (list->vector (iota (vector-length boxes)))
	       boxes)))
