(load "~/code/aoc/load.ss")
(advent-year 20) (advent-day 2)

(define (validate line)
  (match (string-tokenize line)
    ((nums char-colon password)
     (match (map string->number (string-tokenize nums char-set:digit))
       ((lo hi)
	(let ((char (string-ref char-colon 0)))
	  (list (boolean->number (<= lo
				     (count (curry eqv? char)
					    (string->list password))
				     hi))
		(logxor (boolean->number
			 (eqv? char (string-ref password (1- lo))))
			(boolean->number
			 (eqv? char (string-ref password (1- hi))))))))))))

(define input
  (map validate (parse-advent lines-raw)))

(define (solve)
  (map (curry apply +)
       (apply map list input)))
