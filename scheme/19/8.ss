(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 8)

(define rows
  (string->list (car
                 (parse-advent lines-raw)
                 ;;
                 ;; (with-input-from-file "8.in" lines-raw)
                 )))

(define R
  (n-tuples (* 6 25) rows))

(define R*
  (apply map list R))

(define (step color x)
  (case color
    ((#\0 #\1) color)
    (else x)))

(define img
  (map (lambda (row)
         (fold-left step #\2 row))
       R*))

(define (part-b)
  (for-each (lambda (x)
              (display-ln (list->string (map (lambda (x)
                                               x ;; (if (char=? x #\0) #\space #\*)
                                               )
                                             x))))
            (n-tuples 25 img)))

(define (count-char char)
  (lambda (row)
    (count (lambda (c) (char=? c char)) row)))

(define layers
  (sort-on R (count-char #\0)))

(define part-a
  (let ((row (car layers)))
    (* ((count-char #\1) row)
       ((count-char #\2) row))))
