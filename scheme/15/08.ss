(include "~/code/advent/load.ss")
(advent-year 15)
(advent-day 8)

(define codes
  (parse-advent lines-raw))

(define (unescape-length code)
  (with-input-from-string
   code
   (lambda ()
     (let g ((n -2)) ;; for outer quotes
       (let ((x (read-char)))
         (cond
          ((eof-object? x) n)
          ((char=? x #\\)
           (let ((x (read-char)))
             (cond ((char=? x #\x) (read-char) (read-char) (g (1+ n)))
                   (else (g (1+ n))))))
          (else (g (1+ n)))))))))

(define (escape-length code)
  (let ((code (string->list code)))
    (apply + 2 (map (lambda (x)
                      (if (memq x '(#\\ #\")) 2 1))
                    code))))

(define (char-difference code)
  (- (string-length code) (unescape-length code)))

(define (char-difference* code)
  (- (escape-length code) (string-length code)))

(define (part-a)
  (apply + (map char-difference codes)))

(define (part-b)
  (apply + (map char-difference* codes)))

