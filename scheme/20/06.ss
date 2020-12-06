(load "~/code/aoc/load.ss")
(advent-year 20) (advent-day 6)

(define (string->set S)
  (define (insert x S)
    (s:insert (char->integer x) S))
  (fold-right insert s:empty-set (string->list S)))

(define (group answers)
  (let lp ((G '()) (g '()) (answers answers))
    (match answers
      (("" . answers) (lp (cons g G)
			  '()
			  answers))
      ((s  . answers) (lp G
			  (cons (string->set s) g)
			  answers))
      ('()            (cons g G)))))

(define answers
  (group (parse-advent lines-raw)))

(define (part-a)
  (fold-left (lambda (n g)
	       (+ n (s:set-size (apply s:unions g))))
	     0
	     answers))

(define (part-b)
  (fold-left (lambda (n g)
	       (+ n (s:set-size (apply s:intersections g))))
	     0
	     answers))
