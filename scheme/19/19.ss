(load "~/code/aoc/load.ss")
(advent-year 19)
(advent-day 19)

(define program
  (with-input-from-file (advent-file) parse-intcode))

(define tractor
  (intcode program))

(define (check x y)
  (= 1 (beam x y)))

(define (beam x y)
  (car (run-intcode program x y)))

(define (part-a)
  (define on 0)
  (do ((x 0 (1+ x)))
      ((= x 50) on)
    (do ((y 0 (1+ y)))
        ((= y 50) (newline))
      (cond ((check x y)
	     (display #\o)
	     (inc! on))
	    (else (display #\space))))))

(define (random-y x)
  (let ((y (random (* x 2))))
    (if (check x y)
        y
        (random-y x))))

(define (bisect lo hi p?) ; first where predicate true, assuming such a point can be found
  (let bi ((lo lo) (hi hi))
    (if (< hi lo)
        lo
        (let ((m (ash (+ lo hi) -1)))
          (if (p? m)
              (bi lo (1- m))
              (bi (1+ m) hi))))))

(define (range-y x)
  (define y0 (random-y x))
  (values (bisect 0 y0 (lambda (y) (check x y)))
	  (1- (bisect y0 (* 2 x) (lambda (y) (not (check x y)))))))

(define (slink x)
  (define-values (loA hiA) (range-y x))
  (define-values (loB hiB) (range-y (+ x 99)))
  (<= loB (- hiA 99)))

(define (part-b)
  (define x (bisect 0 10000 slink))
  (define-values (loB hiB) (range-y (+ x 99)))
  (+ (* 10000 x) loB))

