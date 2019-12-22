
(load "~/code/advent/load.ss")
(import (scmutils base)
        (scmutils generic))

(define prog
  (map (lambda (s)
         (with-input-from-string s input))
       (parse-advent lines-raw)))

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

(define M
  ;; 10007
  119315717514047
  )
(define reps
  101741582076661)
(define (p x)
  (simplify
   (fold-right permute x (reverse prog))))

(define (iter x n)
  (let ((b (modulo 1670761206531900978952538229230271007672165522370202412103129 M))
        (a (modulo 6945364672106222601370513213752934000383492096000000000000 M)))
    (let ((a^n (expt-mod a n M)))
      (modulo (+ (* x a^n)
                 (* b (- a^n 1) (inverse-modulo (- a 1) M)))
              M))))

(define (olditer x)
  (let ((b (modulo 1670761206531900978952538229230271007672165522370202412103129 M))
        (a (modulo 6945364672106222601370513213752934000383492096000000000000 M)))
    (modulo (+ (* a x) b) M)))

;; ax+b, a(ax+b)+b => a*a*x + a*b + b
;; a*a lot * x + 
(define (permute stmt ix)
  (match stmt
    (('cut n)
     (- ix n))
    (('deal 'with 'increment n)
     (* ix n)
     ;; (modulo (* ix n) M)
     )
    (('deal 'into 'new 'stack)
     (- -1 ix)
     ;; (modulo (- -1 ix) M)
     )))

(define (part-b)
  (iter 2020 (mod (- -1 reps) M)))

(define (scheme->J prog)
  (apply string-append
         (intersperse " "
                      (reverse
                       (cons "i.10007"
                             (map scheme->j prog))))))

(define (order)
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

