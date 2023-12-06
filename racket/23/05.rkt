#lang racket

; (define source-file "05.eg")
(define source-file "../../input/2023/5.in")
(define data
  (string-split (file->string source-file) "\n\n"))
(define (parse-spaced-ints str)
  (map string->number (string-split str " ")))
(define seeds
  (parse-spaced-ints (cadr (string-split (car data) ":"))))
(define (list->func xs)
  (match xs
    (`(,dst ,src ,n)
     (lambda (x)
       (if (<= src x (+ src n -1))
           (+ dst (- x src))
           x)))))
(define (parse-map m) ;; issue is here, values can be mapped multiple times...
  (define fs (map list->func m))
  (lambda (x)
    (let ((ys (remove* (list x) (map (lambda (f) (f x)) fs))))
      (if (null? ys)
          x
          (car ys)))))
(define maps
  (map (lambda (x)
         (parse-map
          (map parse-spaced-ints
               (cdr (string-split x "\n")))))
       (cdr data)))
(define part-a
  (map (foldr compose identity (reverse maps)) seeds))
