
(load "~/code/advent/load.ss")
(import (scmutils base)
        (scmutils generic))

(define shuffle
  (map (lambda (s)
         (with-input-from-string s input))
       ;;        (with-input-from-file "jle.in" lines-raw)
       (parse-advent lines-raw)))

(define M ;; 10007
  119315717514047)
(define reps
  101741582076661)
(define (p x)
  (simplify (fold-right permute x (reverse shuffle))))

;; ax+b, a(ax+b)+b => a*a*x + a*b + b
;; a*a lot * x + ... ~ a^n*x + (a^(n-1) + ... + a + 1)*b => geometric!
(define (iter x n)
  (let ((b (modulo (p 0) M))
        (a (modulo (- (p 1) (p 0)) M)))
    (let ((a^n (expt-mod a n M)))
      (modulo (+ (* x a^n)
                 (* b (- 1 a^n) (inverse-modulo (- 1 a) M)))
              M))))

(define (permute stmt ix)
  (match stmt
    (('cut n)
     (- ix n)) ;; shift by n
    (('deal 'with 'increment n)
     (* ix n)) ;; distribute by n
    (('deal 'into 'new 'stack)
     (- -1 ix)) ;; reverse (-1 for 0-indexing reasons)
    ))

(define (part-a)
  (set! M 10007)
  (iter 2019 1))

(define (part-b)
  (set! M 119315717514047)
  (iter 2020 (mod (- -1 reps) M)))

(define (number->j n)
  (if (< n 0)
      (string-append "_" (number->string (- n)))
      (number->string n)))

(define (scheme->j stmt)
  (match stmt
    (('cut n)
     (string-append (number->j n) " |. "))
    (('deal 'with 'increment n)
     (string-append (number->j n) " dwi "))
    (('deal 'into 'new 'stack)
     " |. ")))

(define (scheme->J prog)
  (apply string-append
         (intersperse " "
                      (reverse
                       (cons "i.10007"
                             (map scheme->j prog))))))

(define (order) ;; nooope
  (define pro (reverse prog))
  ;;  (define ps '(2020))
  (do ((i 1 (1+ i))
       (p (iter 2020)
          (iter p)))
      ((= p 2020) i)
    (when (zero? (mod i 10000))
      (display-ln (list i p)))))

;; cut has effect of moving index by + modulo
;; new stack has effect of negating modulo

