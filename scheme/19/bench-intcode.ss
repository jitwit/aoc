(optimize-level 3)
(load "~/code/advent/load.ss")

(define (bench-intcode src-file . input)
  (define src (with-input-from-file src-file comma-separated))
  (format #t "~%~a ~a~%" src-file input)
  (collect-maximum-generation)
  (time
   (apply run-intcode src input)))

(define (sum-primes-ic n)
  (bench-intcode "sum-primes.intcode" n))

(define (ackermann-ic m n)
  (bench-intcode "ackermann.intcode" m n))

(define (isqrt-ic n)
  (bench-intcode "isqrt.intcode" n))

(define (divmod-ic m n)
  (bench-intcode "divmod.intcode" m n))

(define (factor-ic n)
  (bench-intcode "factor.intcode" n))

(define (bench!)
  (let ((transcript "~/code/advent/output/intcode-bench.txt"))
    (delete-file transcript)
    (transcript-on transcript)
    (sum-primes-ic 100000)
    (sum-primes-ic 2000000)
    (ackermann-ic 3 6)
    (divmod-ic 1024 3)
    (isqrt-ic 130)
    (factor-ic 2147483647)
    (factor-ic 19201644899)
    (transcript-off)))
