(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 6)

(define solar-system
  (let ((children (make-hashtable string-hash string=?))
        (parents (make-hashtable string-hash string=?)))
    (for-all (lambda (pq)
               (let ((p (substring pq 0 3))
                     (q (substring pq 4 7)))
                 (hashtable-set! parents q p)
                 (hashtable-update! children
                                    p
                                    (lambda (qs)
                                      (cons q qs))
                                    '())))
             (parse-advent lines-raw))
    (lambda (me)
      (case me
        ((parents) parents)
        ((children) children)))))

(define (children planet)
  (hashtable-ref (solar-system 'children) planet '()))

(define (parent planet)
  (hashtable-ref (solar-system 'parents) planet #f))

(define (count-orbits planet)
  (let ((count 0))
    (let walk ((p planet) (d 1))
      (for-all (lambda (q)
                 (set! count (+ count d))
                 (walk q (1+ d)))
               (children p)))
    count))

(count-orbits "COM")

(define (solar-path planet)
  (let walk ((planet planet) (path '()))
    (cond ((parent planet) => (lambda (p)
                                (walk p (cons p path))))
          (else path))))

(define (orbital-transfers P Q)
  (let walk ((ps (solar-path P)) (qs (solar-path Q)))
    (if (string=? (car ps) (car qs))
        (walk (cdr ps) (cdr qs))
        (+ (length ps) (length qs)))))

(orbital-transfers "SAN" "YOU")
