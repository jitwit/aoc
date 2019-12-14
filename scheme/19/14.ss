(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 14)

(define (p0 s)
  (string-tokenize s (char-set-complement (char-set #\= #\>))))

(define rules
  (map (lambda (rule)
         (match (p0 rule)
           ((in out)
            (cons (with-input-from-string out comma-separated)
                  (n-tuples 2 (with-input-from-string in comma-separated))))))
       ;;       (with-input-from-file "medium.in" lines-raw)
       ;;
       (parse-advent lines-raw)
       ))

(define (lookup chem)
  (find (lambda (rule)
          (eq? chem (cadar rule)))
        rules))

(define (close chem)
  (cond ((lookup chem)
         => (lambda (rule)
              (apply append
                     (map (lambda (x)
                            (cons (cons chem (cadr x))
                                  (close (cadr x))))
                          (cdr rule)))))
        (else '())))

(define (organize)
  (define G (make-hash-table))
  (define seen (make-hash-table))
  (define X '())
  (define (dfs x)
    (unless (hashtable-ref seen x #f)
      (hashtable-set! seen x #t)
      (for-all dfs (hashtable-ref G x '()))
      (push! x X)))
  (for-all (lambda (rule)
             (hashtable-update! G
                                (car rule)
                                (lambda (chems)
                                  (if (memq (cdr rule) chems)
                                      chems
                                      (cons (cdr rule) chems)))
                                '()))
           (close 'FUEL))
  (dfs 'FUEL)
  (values G X))



(define (produce G xs n)
  (define chems (make-hash-table))
  (define ore 0)
  (hashtable-set! chems 'FUEL n)
  (let loop ((xs xs))
    (match xs
      ((x xs ...)
       (let ((n (hashtable-ref chems x 0)))
         (match (lookup x)
           (((r x*) rs ...)
            (let ((q (quotient (+ n r -1) r)))
              (for-all (lambda (ing)
                         (hashtable-update! chems
                                            (cadr ing)
                                            (lambda (m)
                                              (+ m (* q (car ing))))
                                            0))
                       rs)))
           (else (display-ln x)))
         (loop xs)))
      (else (hashtable-ref chems 'ORE 0)))))

(define (partA)
  (define-values (G xs) (organize))
  (produce G xs 1))

(define (partB)
  (define-values (G xs) (organize))
  (define trillion (expt 10 12))
  (let bin ((lo 1) (hi 1000000000))
    (if (< hi lo)
        hi
        (let ((x (ash (+ lo hi) -1)))
          (let ((ore (produce G xs x)))
            (display-ln (list x ore))
            (if (<= ore trillion)
                (bin (1+ x) hi)
                (bin lo (1- x))))))))
