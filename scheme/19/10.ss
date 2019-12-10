(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 10)

(define grid
  (map string->list (parse-advent lines-raw)))

(define points
  (filter-map
   identity
   (apply append
          (map (lambda (i row)
                 (map (lambda (j x)
                        (and (char=? x #\#)
                             (+ j (* 0+i i))))
                      (enumerate row)
                      row))
               (enumerate grid)
               grid))))

(define pi/2
  (acos 0))

(define 2pi
  (* 4 pi/2))

(define (phi z)
  (let ((a (angle (* 0+i z))))
    (if (< a 0) (- a) (- 2pi a))))

(define (visible x)
  (length
   (group-with
    equal?
    (sort <
          (filter-map (lambda (z)
                        (let ((z-x (- z x)))
                          (and (not (zero? z-x))
                               (angle z-x))))
                      points)))))

(define (part-a)
  (car (last-pair (rank-on points visible))))

(define home
  (cdr (part-a)))

(define asteroids
  (sort-on (filter-map (lambda (z)
                         (and (not (= z home))
                              (- z home)))
                       points)
           (compose - phi)))

(define (part-b)
  (let loop ((j 1) (zs asteroids))
    (if (= j 200)
        (+ home (car zs))
        (let ((alpha (angle (car zs))))
          (let-values (((as bs)
                        (partition (lambda (u)
                                     (equal? (angle u) alpha))
                                   (cdr zs))))
            (loop (1+ j) `(,@bs ,@as)))))))

