(load "~/code/advent/load.ss")
(load "~/code/advent/code/vm18.ss")

(advent-day 16)
(advent-year 18)

(define instructions/tests
  (parse-advent lines-raw))

(define run-test
  (lambda (before instr after)
    (lambda (proc)
      (reset-registers before)
      (apply proc (cdr instr))
      (if (equal? (vector->list *registers*) after)
	  (cons proc (car instr))
	  #f))))

(define program
  (let loop ((xs instructions) (j 0))
    (cond ((and (= j 2) (null? (car xs))) (cdr xs))
	  ((null? (car xs)) (loop (cdr xs) (1+ j)))
	  (else (loop (cdr xs) 0)))))

(define tests
  (map (lambda (tuple)
	 (list-head tuple 3))
       (n-tuples 4
		 (list-head instructions
			    (- (length instructions)
			       (length program)
			       2)))))

;; run the test cases and remove op codes that don't match up 
(define analyze-proc
  (lambda (proc)
    (let ((run (lambda (test)
		 ((apply run-test test) proc))))
      (fold-left (lambda (ops test)
		   (let ((result (run test))
			 (op (caadr test)))
		     (if result
			 ops
			 (s:delete op ops))))
		 (apply s:unions (iota 16))
		 tests))))

(define (swap ab)
  (cons (cdr ab) (car ab)))

;; when a variable has 1 option, remove that option from others
(define (constrain assignment) 
  (let-values (((xs ys) (partition (lambda (a)
				     (= (s:set-size (cdr a)) 1))
				   assignment)))
    (let* ((occ (apply s:unions (map cdr xs)))
	   (zs (map swap xs)))
      (if (null? ys)
	  zs
	  (append zs (constrain (map (lambda (y)
				       (cons (car y)
					     (s:difference (cdr y) occ)))
				     ys)))))))

(define (count pred list)
  (length (filter pred list)))

(define (part-a)
  (count (lambda (test)
	   (let ((test-op (apply run-test test)))
	     (<= 3 (count test-op instruction-set))))
	 tests))

(define (part-b)
  (let ((code (constrain (map (lambda (p)
				(cons p (analyze-proc p)))
			      instruction-set))))
    (reset-registers '(0 0 0 0))
    (for-each (lambda (instr)
		(let* ((op (car instr))
		       (mach (cdr (assq op code)))
		       (args (cdr instr)))
		  (apply mach args)))
	      program)
    (fetch 0)))

(define (solve)
  (format #t "~a~%~a~%" (part-a) (part-b)))
