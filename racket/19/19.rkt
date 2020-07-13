#lang racket

(require "intcode.rkt")

(define program
  (with-input-from-file "../../input/19/19.in" parse-intcode))

(define-syntax inc!
  (syntax-rules ()
    ((_ x)
     (set! x (+ x 1)))))

(define (1+ x)
  (+ x 1))

(define (1- x)
  (- x 1))

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
        ((= y 50))
      (when (check x y)
        (inc! on)))))

(define (random-y x)
  (let ((y (random (* x 2))))
    (if (check x y)
        y
        (random-y x))))

; first where predicate true, assuming such a point can be found
(define (bisect lo hi p?) 
  (let bi ((lo lo) (hi hi))
    (if (< hi lo)
        lo
        (let ((m (arithmetic-shift (+ lo hi) -1)))
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

