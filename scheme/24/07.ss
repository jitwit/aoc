(load "~/code/aoc/load.ss")
(advent-year 24) (advent-day 07)

(define input
  (map (lambda (line)
	 (match (string-tokenize line (char-set-complement (char-set #\:)))
	   ((target test-values)
	    (map string->number (cons target (string-tokenize test-values))))))
       (parse-advent lines-raw)))

(define (|| . args)
  (string->number
   (apply string-append (map number->string args))))

(define (iterate target numbers operators)
  (match numbers
    ((n) (= target n))
    ((x y zs ...)
     (ormap (lambda (operator)
              (iterate target (cons (operator x y) zs) operators))
            operators))
    (_ (error 'iter "oops"))))

(define (solve operators problem)
  (iter (car problem) (cdr problem) operators))

(define (part-a)
  (apply + (map car (filter (curry solve (list + *)) input))))

(define (part-b)
  (apply + (map car (filter (curry solve (list + * ||)) input))))
