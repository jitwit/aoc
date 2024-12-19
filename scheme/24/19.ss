(load "~/code/aoc/load.ss")
(advent-year 24) (advent-day 19)
(define patterns) (define designs)
(define (init)
  (match (parse-advent lines-raw ;; "small.in"
		       )
    ((ps "" ds ...)
     (set! patterns (string-split ps ", "))
     (set! designs ds))))

(defmemo (F design : string)
  (if (string-null? design)
      1
      (fold-right (lambda (pattern n)
		    (+ n
		       (if (string-prefix? pattern design)
			   (F (substring design
					 (string-length pattern)
					 (string-length design)))
			   0)))
		  0
		  patterns)))

(define (part-a)
  (count (compose (curry < 0) F) designs))

(define (part-b)
  (apply + (map F designs)))

(define (main)
  (init)
  (solve-advent part-a part-b))
