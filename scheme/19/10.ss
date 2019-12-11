(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 10)

(define points
  (let ((grid (map string->list
                   (with-input-from-file "../../J/19/gl.in" lines-raw)
                   ;; (parse-advent lines-raw)
                   )))
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

;; to make 0 clockwise pointing up, which is actually down because the
;; coordinates are wonky.
(define (phi z)
  (let ((a (angle (* 0+i z))))
    (if (< a 0) a (- a 2pi))))

(define (split-ray alpha zs)
  (drop-while (lambda (z) (equal? (angle z) alpha)) zs))

(define (translating points center)
  (sort-on (filter-map (lambda (z)
                         (and (not (= z center))
                              (- z center)))
                       points)
           phi))

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
  (maximum-on points visible))

(define monitoring-station
  (cdr (part-a)))

;; problem asks for 200th of 303, so this just drops hidden points
(define (part-b)
  (let loop ((j 1) (zs (translating points monitoring-station)))
    (let ((z (car zs)))
      (if (= j 200)
          (+ monitoring-station z)
          (let ((zs* (split-ray (angle z) (cdr zs))))
            (loop (1+ j) zs*))))))

