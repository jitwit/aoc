(load "~/code/advent/load.ss")
(advent-year 15)
(advent-day 10)

(define start
  (digits (car (parse-advent input))))

(group-with = start)

(define (expand-rle ds)
  (apply append
         (map (lambda (x)
                `(,@(digits (length x)) ,(car x)))
              (group-with = ds))))

(define (solve)
  (let ((a #f))
    (do ((i 0 (1+ i))
         (digs start (expand-rle digs)))
        ((> i 40) a)
      (when (= i 40)
        (set! a (length digs))))))

(define (part-a)
  (length (s:ref (s:iter expand-rle start) 50)))





