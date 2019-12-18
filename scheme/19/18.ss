(load "~/code/advent/load.ss")

(advent-year 19)
(advent-day 18)

(define inlines
  (parse-advent lines-raw)
  ;;  (with-input-from-file "small.in" lines-raw)
  )

(define dat
  (list->vector (map list->vector (map string->list inlines))))

(define h (1- (vector-length dat)))
(define w (1- (vector-length (vector-ref dat 0))))

(define (inbounds? z)
  (and (<= 0 (real-part z) h)
       (<= 0 (imag-part z) w)))

(define (adj node)
  (let ((oks (cdr node)))
    (filter-map (lambda (z*)
                  (and (inbounds? z*)
                       (let ((x (mref z*)))
                         ;; probably want charset
                         (cond ((memv (char-upcase x) oks)
                                (cons z* oks))
                               ((char-lower-case? x)
                                (cons z* (sort char<? (cons (char-upcase x) oks))))
                               (else #f)))))
                (grid4 (car node)))))

(define (locate obj)
  (call/cc
   (lambda (k)
     (do ((i 0 (1+ i)))
         ((> i h))
       (do ((j 0 (1+ j)))
           ((> j w))
         (let ((z (make-rectangular i j)))
           (when (char=? obj (mref z))
             (k z))))))))

(define (mref z)
  (vector-ref (vector-ref dat (real-part z)) (imag-part z)))

(define keys
  (map (compose integer->char (curry + 97)) (iota 26)))

(define doors
  (map char-upcase keys))

;; search until a char is hit. if that char's a door, can't go. if
;; that char's a key, stop?

(define (start-node z)
  (cons z '(#\. #\@)))

(define mbfs
  (lambda (v done?)
    (call/cc
     (lambda (done)
       (define seen (make-hashtable equal-hash equal?))
       (define i 0)
       (hashtable-set! seen v #t)
       (let bfs ((Q (q:consq (cons 0 v) q:empty)))
         (inc! i)
         (when (zero? (mod i 10000))
           (display-ln i))
         (unless (q:empty? Q)
           (let ((d.v (q:headq Q)))
             (let ((d (car d.v)) (v (cdr d.v)))
               (bfs (fold-left (lambda (Q w)
                                 (cond ((not (hashtable-ref seen w #f))
                                        (when (done? w)
                                          (display-ln w)
                                          (done (1+ d)))
                                        (hashtable-set! seen w #t)
                                        (q:snocq Q (cons (1+ d) w)))
                                       (else Q)))
                               (q:tailq Q)
                               (adj v)))))))))))

(define (search)
  (mbfs (start-node (locate #\@))
        (lambda (xs)
          (= 29 (length xs)))))

(define (partB)
  #f)

(define solve
  #f)
