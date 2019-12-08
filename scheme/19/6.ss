(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 6)

(define child-table (make-hashtable string-hash string=?))
(define parent-table (make-hashtable string-hash string=?))

(define (init)
  (for-all (lambda (pq)
             (let ((p (substring pq 0 3))
                   (q (substring pq 4 7)))
               (hashtable-set! parent-table q p)
               (hashtable-update! child-table
                                  p
                                  (lambda (qs)
                                    (cons q qs))
                                  '())))
           (parse-advent lines-raw)))

(init)

(define (children planet)
  (hashtable-ref child-table planet '()))

(define (parent planet)
  (hashtable-ref parent-table planet #f))

(define (count-orbits planet)
  (let ((count 0))
    (let walk ((p planet) (d 1))
      (for-all (lambda (q)
                 (set! count (+ count d))
                 (walk q (1+ d)))
               (children p)))
    count))

(display-ln (count-orbits "COM"))

(define (solar-path planet)
  (let walk ((planet planet) (path '()))
    (cond ((parent planet)
           => (lambda (parent)
                (walk parent (cons parent path))))
          (else path))))

(define (orbital-transfers P Q)
  (let walk ((ps (solar-path P)) (qs (solar-path Q)))
    (if (equal? (car ps) (car qs))
        (walk (cdr ps) (cdr qs))
        (+ (length ps) (length qs)))))

(display-ln (orbital-transfers "SAN" "YOU"))
