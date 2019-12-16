(load "~/code/advent/load.ss")

(advent-year 19)
(advent-day 16)

(define digs
  (parse-advent read))

(define s0
  (digits digs))

(define (end-dig n)
  (mod (abs n) 10))

(define base-pattern
  (s:cycle '(0 1 0 -1)))

(define (kth-pattern k)
  (s:cdr (s:bind (lambda (x)
                   (make-list k x))
                 base-pattern)))

(define (phase digs)
  (let ((n (length digs)))
    (map (lambda (k)
           (end-dig (fold-left + 0 (map * digs (s:take n (kth-pattern (1+ k)))))))
         (enumerate digs))))

(define (part-a)
  (digits->integer (list-head (s:ref (s:iter phase s0) 100) 8)))

