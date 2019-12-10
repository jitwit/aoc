(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 10)

(define points
  (let ((grid (map string->list
                   (parse-advent lines-raw))))
    (filter-map identity
                (apply append
                       (map (lambda (i row)
                              (map (lambda (j x)
                                     (and (eqv? x #\#)
                                          (+ j (* 0+i i))))
                                   (enumerate row)
                                   row))
                            (enumerate grid)
                            grid)))))

;; translate points based on x
(define (part-a)
  (define (visible x)
    (length
     (group-with equal?
                 (sort <
                       (filter-map (lambda (z)
                                     (let ((z-x (- z x)))
                                       (and (not (zero? z-x))
                                            (angle z-x))))
                                   points)))))
  (car (last-pair (rank-on points visible))))

(define monitoring-station
  (cdr (part-a)))

;; to make 0 clockwise pointing up, which is actually down because the
;; coordinates are wonky.
(define (phi z)
  (let ((a (angle (* 0+i z))))
    (if (< a 0) a (- a 2pi))))

(define asteroids
  (sort-on (filter-map (lambda (z)
                         (and (not (= z monitoring-station))
                              (- z monitoring-station)))
                       points)
           phi))

(define (split-ray alpha zs)
  (drop-while (lambda (z) (equal? (angle z) alpha)) zs))

;; problem asks for 200th of 303, so this just drops hidden points
(define (part-b)
  (let loop ((j 1) (zs asteroids))
    (let ((z (car zs)))
      (if (= j 200)
          (+ monitoring-station z)
          (let ((zs* (split-ray (angle z) (cdr zs))))
            (loop (1+ j) zs*))))))

