(load "~/code/advent/load.ss")

(define intcode
  (parse-advent comma-separated))

(define (spring-script)
  (define T #f) (define J #f)
  #f
  )

(define m (cpu intcode))

(define (showme M)
  (for-all (compose display integer->char) (read-output M)))

(define (giveme M msg)
  (apply M 'in `(,@(map char->integer (string->list msg)))))

(define (read-in k)
  (let loop ((x (read)) (xs '()))
    (cond ((eq? x 'go)
           (let ((out
                  (string-upcase
                   (apply string-append
                          (intersperse " "
                                       (map symbol->string
                                            (reverse
                                             (cons
                                              (string->symbol "\n") xs))))))))
             (write out) (newline)
             out))
          ((eq? x 'quit)
           (k 'quitting))
          (else (loop (read) (cons x xs))))))

(define (runme M)
  (call/cc
   (lambda (quit)
     (let loop ()
       (let ((ops (trace-opcodes M)))
         ;;          (for-all display-ln ops)
         (showme M)
         (cond ((done? M)
                (display-ln (dump-cache2 M)))
               (else
                (giveme M (read-in quit))
                (loop))))))))
