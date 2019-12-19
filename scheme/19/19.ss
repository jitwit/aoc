(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 19)

(define intcode
  (parse-advent comma-separated))

(define tractor (cpu intcode))

(define (check x y)
  (= 1 (beam x y)))

(define (beam x y)
  (reset! tractor)
  (tractor 'in x y)
  (run-until-halt tractor)
  (get-output tractor))

(define (partA)
  (define on 0)
  (do ((x 0 (1+ x)))
      ((= x 50)
       on)
    (do ((y 0 (1+ y)))
        ((= y 50))
      (when (check x y)
        (inc! on)))))

(define (showme r)
  (do ((y 0 (1+ y)))
      ((= y r))
    (do ((x 0 (1+ x)))
        ((= x r) (newline))
      (if (check x y)
          (display #\O)
          (display #\space)))))

(define (random-y x)
  (let ((y (random (* x 2))))
    (if (check x y)
        y
        (random-y x))))

(define (random-x y)
  (let ((x (random y)))
    (if (check x y)
        x
        (random-x y))))

(define (bisect lo hi predicate) ;; first where predicate true, assuming such a point can be found
  (let cut ((lo lo) (hi hi))
    (if (< hi lo)
        lo
        (let ((m (ash (+ lo hi) -1)))
          (if (predicate m)
              (cut lo (1- m))
              (cut (1+ m) hi))))))

(define (range-y x)
  (define y0 (random-y x))
  (list (bisect 0 y0 (lambda (y) (check x y)))
        (1- (bisect y0 (* 2 x) (lambda (y) (not (check x y)))))))

(define (slink x)
  (define-values (loA hiA) (apply values (range-y x)))
  (define-values (loB hiB) (apply values (range-y (+ x 99))))
  (<= loB (- hiA 99)))

(define (partB)
  (define x (bisect 0 10000 slink))
  (define-values (loB hiB) (apply values (range-y (+ x 99))))
  (+ (* 10000 x) loB))

