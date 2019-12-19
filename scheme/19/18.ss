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
  (let ((locked (cdr node)))
    (filter-map (lambda (z*)
                  (and (inbounds? z*) ;; in grid
                       (let ((x (mref z*)))
                         (cond ((and (char-upper-case? x)
                                     (not (memv x locked)))
                                (cons z* locked))
                               ((char-lower-case? x) ;; if key, unlock door
                                (cons z* (remove (char-upcase x) locked)))
                               (else (and (memv x '(#\@ #\.))
                                          (cons z* locked)))))))
                (grid4 (car node)))))

(define (showme)
  (do ((i 0 (1+ i)))
      ((> i h))
    (do ((j 0 (1+ j)))
        ((> j w) (newline))
      (let ((x (mref (make-rectangular i j))))
        (case x
          ((#\.) (display #\space))
          ((#\#) (display-with-foreground 'yellow #\#))
          (else (display-with-foreground 'red x)))))))

(define (search-in-region a b c d)
  (define keys
    (keys-in-region a b c d))
  (mbfs (cons (car (filter (lambda (z)
                             (and (<= a (real-part z) b)
                                  (<= c (imag-part z) d)))
                           (locate #\@)))
              (map char-upcase keys))
        adj
        (compose null? cdr)))

(define (keys-in-region a b c d)
  (define keys (make-eqv-hashtable))
  (do ((i a (1+ i)))
      ((> i b) (vector->list (hashtable-keys keys)))
    (do ((j c (1+ j)))
        ((> j d))
      (let ((x (mref (make-rectangular i j))))
        (when (char-lower-case? x)
          (hashtable-set! keys x #t))))))

(define (locate obj)
  (define locs '())
  (do ((i 0 (1+ i)))
      ((> i h) locs)
    (do ((j 0 (1+ j)))
        ((> j w))
      (let ((z (make-rectangular i j)))
        (when (char=? obj (mref z))
          (push! z locs))))))

(define (mref z)
  (vector-ref (vector-ref dat (real-part z)) (imag-part z)))

(define (mset! z x)
  (vector-set! (vector-ref dat (real-part z)) (imag-part z) x))

(define mbfs
  (lambda (v adj done?)
    (call/cc
     (lambda (done)
       (define seen (make-hashtable equal-hash equal?))
       (hashtable-set! seen v #t)
       (let bfs ((Q (q:consq (cons 0 v) q:empty)))
         (unless (q:empty? Q)
           (let ((d.v (q:headq Q)))
             (let ((d (car d.v)) (v (cdr d.v)))
               (bfs (fold-left (lambda (Q w)
                                 (cond ((not (hashtable-ref seen w #f))
                                        (when (done? w)
                                          (done (1+ d)))
                                        (hashtable-set! seen w #t)
                                        (q:snocq Q (cons (1+ d) w)))
                                       (else Q)))
                               (q:tailq Q)
                               (adj v)))))))))))

(define (tweak-dat)
  (let ((z0 (car (locate #\@))))
    (for-all mset! (cons z0 (grid8 z0)) '(#\# #\@ #\# #\@ #\# #\# #\@ #\# #\@))))

(define (partA)
  (search-in-region 0 h 0 w))

(define (partB)
  (+ (search-in-region 0 (/ h 2) 0 (/ w 2))
     (search-in-region 0 (/ h 2) (/ w 2) w)
     (search-in-region (/ h 2) h 0 (/ w 2))
     (search-in-region (/ h 2) h (/ w 2) w)))

(define (solve)
  (display-ln (partA))
  (tweak-dat)
  (display-ln (partB)))
