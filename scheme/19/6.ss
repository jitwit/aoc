(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 6)

(define orbits
  (map (lambda (line)
         (cons (substring line 0 3)
               (substring line 4 7)))
       (parse-advent lines-raw)))

(define solar-system
  (let ((tree (make-hashtable string-hash string=?)))
    (for-all (lambda (pq)
               (hashtable-update! tree (car pq) (lambda (qs) (cons (cdr pq) qs)) '()))
             orbits)
    tree))

(define (count-orbits planet)
  (let ((count 0))
    (let walk ((p planet) (d 1))
      (for-all (lambda (q)
                 (set! count (+ count d))
                 (walk q (1+ d)))
               (hashtable-ref solar-system p '())))
    count))

(define (solar-path earth planet)
  (call/cc
   (lambda (path)
     (let walk ((curr earth) (planets (list earth)))
       (if (string=? curr planet)
           (path (reverse planets))
           (for-all (lambda (q)
                      (walk q (cons q planets)))
                    (hashtable-ref solar-system curr '())))))))

(define (orbital-transfers P Q)
  (let ((ps (solar-path "COM" P))
        (qs (solar-path "COM" Q)))
    (let walk ((ps ps) (qs qs))
      (if (string=? (car ps) (car qs))
          (walk (cdr ps) (cdr qs))
          (+ -2 (length ps) (length qs))))))

(define (solve)
  (display-ln
   (count-orbits "COM"))
  (display-ln
   (orbital-transfers "SAN" "YOU")))
