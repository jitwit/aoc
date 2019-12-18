(load "~/code/advent/load.ss")

(advent-year 19)
(advent-day 18)

(define inlines
  (parse-advent lines-raw)
  ;; (with-input-from-file "tiny.in" lines-raw)
  )

(define dat
  (list->vector (map list->vector (map string->list inlines))))

(define h (1- (vector-length dat)))
(define w (1- (vector-length (vector-ref dat 0))))

(define (inbounds? z)
  (and (<= 0 (real-part z) h)
       (<= 0 (imag-part z) w)))

(define (gridB node)
  (let ((zs (car node)))
    (map (lambda (z)
           (map (lambda (z*)
                  (map (lambda (z**)
                         (if (eqv? z** z)
                             z*
                             z**))
                       zs))
                (grid4 z)))
         zs)))

(define (adjA node)
  (let ((oks (cdr node)))
    (filter-map (lambda (z*)
                  (and (inbounds? z*) ;; in grid
                       (let ((x (mref z*)))
                         (cond ((memv (char-upcase x) oks) ;; if door is open, new loc isok
                                (cons z* oks))
                               ((char-lower-case? x) ;; if key, add to open doors
                                (cons z* (sort char<? (cons (char-upcase x) oks))))
                               (else #f))))) ;; else door not open or hash
                (grid4 (car node)))))

(define (bfs-key node)
  (define nodes '())
  (define seen (make-eqv-hashtable))
  (define d (car node))
  (define unlocked (cddr node))
  (let loop ((Q (q:consq (cons (cadr node) d) q:empty)))
    (unless (q:empty? Q)
      (let* ((z.d (q:headq Q))
             (z (car z.d))
             (d (cdr z.d)))
        (loop (fold-right (lambda (z* Q)
                            (if (not (inbounds? z*))
                                Q
                                (let ((x (mref z*)))
                                  (cond
                                   ((char=? x #\#) Q)
                                   ((hashtable-ref seen z* #f) Q)
                                   ((and (char-upper-case? x) (not (memv x unlocked))) Q)
                                   (else
                                    (hashtable-set! seen z* #t)
                                    (when (and (char-lower-case? x)
                                               (not (memv (char-upcase x) unlocked)))
                                      (push! (cons* (1+ d) z* (sort char<? (cons (char-upcase x) unlocked)))
                                             nodes))
                                    (q:snocq Q (cons z* (1+ d))))))))
                          (q:tailq Q)
                          (grid4 z))))))
  nodes)

(define (partA)
  (define keylen
    (+ 2 (length
          (filter char-lower-case?
                  (nub-equal
                   (apply append
                          (vector->list (vector-map vector->list dat))))))))
  (mbfs (cons (car (locate #\@))
              '(#\. #\@))
        adjA
        (lambda (xs)
          (= keylen (length (cdr xs))))))

(define keys
  (sort char<?
        (map char-upcase
             (filter char-lower-case?
                     (nub-equal
                      (apply append
                             (vector->list (vector-map vector->list dat))))))))

(define (searchA)
  (define seen (make-hashtable equal-hash equal?))
  (define i 0)
  (let ((node0 (cons* 0 (car (locate #\@)) '())))
    (let explore ((h (h:insert 0 node0 h:empty)))
      (inc! i)
      (if (h:empty? h)
          'failure
          (let-values (((d node h*) (apply values (h:view-min h))))
            (when (zero? (mod i 500))
              (display-ln (cons i node)))
            (if (equal? keys (cddr node))
                node
                (explore (fold-right (lambda (res h*)
                                       (let* ((doors (cddr res))
                                              (prev (hashtable-ref seen doors #f))
                                              (curr (car res)))
                                         (cond ((or (not prev) (< curr prev))
                                                (hashtable-set! seen doors curr)
                                                (h:insert curr res h*))
                                               (else h*))))
                                     h*
                                     (bfs-key node)))))))))

(define (canonzs zs)
  (sort (lambda (u v)
          (or (<= (real-part u)
                  (real-part v))
              (<= (imag-part u)
                  (imag-part v))))
        zs))

(define (focus-a node)
  (map (lambda (z)
         (cons z (cdr node)))
       (car node)))

(define (adjB node);; reuse adja?
  (let ((zs (car node)))
    (let ((nodes (apply append
                        (map (lambda (n)
                               (let ((zs (remove (car n) zs)))
                                 (map (lambda (n*)
                                        (cons (cons (car n*) zs)
                                              (cdr n*)))
                                      (adjA n))))
                             (focus-a node)))))
      (maximums-on nodes (compose length cdr)))))

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
       (define i 0)
       (hashtable-set! seen v #t)
       (let bfs ((Q (q:consq (cons 0 v) q:empty)))
         (inc! i)
         (unless (q:empty? Q)
           (let ((d.v (q:headq Q)))
             (let ((d (car d.v)) (v (cdr d.v)))
               (when (zero? (mod i 10000)) (display-ln (cons i d)))
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



(define (tweak-dat)
  (let ((z0 (car (locate #\@))))
    (for-all mset! (cons z0 (grid8 z0)) '(#\# #\@ #\# #\@ #\# #\# #\@ #\# #\@))))

(define (partB)
  (define keylen
    (+ 2 (length
          (filter char-lower-case?
                  (nub-equal
                   (apply append
                          (vector->list (vector-map vector->list dat))))))))
  ;;  (tweak-dat)
  (mbfs (cons (locate #\@) '(#\. #\@))
        adjB
        (lambda (xs)
          (= keylen (length (cdr xs))))))

(define solve
  #f)
