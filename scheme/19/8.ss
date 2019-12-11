(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 8)

(define encoded-image
  (string->list (car (parse-advent lines-raw))))

(define layers
  (n-tuples (* 6 25) encoded-image))

(define (color-pixel layers)
  (fold-left (lambda (color x)
               (case color
                 ((#\0 #\1) color)
                 (else x)))
             #\2
             layers))

(define (counting thing xs)
  (count (curry eqv? thing) xs))

(define (part-a)
  (let ((row (maximum-on layers (compose - (curry counting #\0)))))
    (* (counting #\1 row) (counting #\2 row))))

(define (part-b)
  (let ((decoded
         (apply append
                (map (lambda (j row)
                       (map (lambda (i pixel)
                              (and (eqv? #\1 pixel)
                                   (make-rectangular i j)))
                            (iota 25)
                            row))
                     (iota 6)
                     (n-tuples 25 (map color-pixel (apply map list layers)))))))
    (run-ssvg (zs->ssvg (filter number? decoded)) "Day8.svg")))




