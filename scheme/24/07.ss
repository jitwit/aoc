(load "~/code/aoc/load.ss")
(advent-year 24) (advent-day 07)

(define in
  (map (lambda (line)
	 (match (string-tokenize line (char-set-complement (char-set #\:)))
	   ((target test-values)
	    (map string->number (cons target (string-tokenize test-values))))))
       (parse-advent lines-raw)))

(define (|| x y)
  (string->number
   (string-append (number->string x) (number->string y))))

(define (iterate operators partial-solutions)
  (define (step operators numbers)
    (match numbers
      ((n) numbers)
      ((x y zs ...)
       (map (lambda (operator)
	      (cons (operator x y) zs))
	    operators))))
  (append-map (curry step operators) partial-solutions))

(define (solve operators problem)
  (let ((target (car problem)))
    (let lp ((partial-solutions (list (cdr problem))))
      (cond ((and (list? partial-solutions)
		  (list? (car partial-solutions)))
	     (lp (iterate operators partial-solutions)))
	    (else (member target partial-solutions))))))

(define (part-a)
  (apply + (map car (filter-map (curry solve (list + *)) in))))

(define (part-b)
  (apply + (map car (filter-map (curry solve (list + * ||)) in))))
