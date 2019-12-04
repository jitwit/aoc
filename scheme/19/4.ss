(load "~/code/advent/load.ss")

(define range
  (symbol->string (car (parse-advent input))))

(define (okok? xs)
  (let loop ((xs (cdr xs)) (x (car xs)) (c 1))
    (if (null? xs)
        (= c 2)
        (let ((y (car xs)))
          (cond ((= y x)
                 (loop (cdr xs) x (1+ c)))
                (else
                 (or (= c 2)
                     (loop (cdr xs) y 1))))))))

(define (good? ds)
  (let ((beg (list-head ds 5))
        (end (cdr ds)))
    (and (ormap = beg end)
         (andmap <= beg end)
         (okok? ds))))

(define (solve)
  (define n 0)
  (do ((x 134792 (1+ x)))
      ((= x 675810) n)
    (when (good? (digits x))
      (inc! n))))
