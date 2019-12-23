(load "~/code/advent/load.ss")

(define prog
  (parse-advent comma-separated))

(define (cat6-network)
  (define V (make-vector 50))
  (do ((i 0 (1+ i)))
      ((= i 50) V)
    (let ((nic (cpu prog)))
      (send-input nic i)
      (run-until-halt nic)
      (vector-set! V i nic))))

(define (run-network network)
  (vector-for-each run-until-halt network))

(define (feed--1 network)
  (vector-for-each (lambda (nic) (send-input nic -1)) network))

(define (collect-packets network)
  (let scan ((i 0) (packets '()))
    (if (= i 50)
        packets
        (scan (1+ i) (append (read-output (vector-ref network i)) packets)))))

(define (runA)
  (call/cc
   (lambda (done)
     (define network (cat6-network))
     (define (send-packets Q)
       (if (null? Q)
           (feed--1 network)
           (let send ((Q Q))
             (match Q
               ((255 _ y z ...)
                (done y))
               ((a x y z ...)
                (send-input* (vector-ref network a) (list x y))
                (send z))
               (() (void))))))
     (let loop ()
       (run-network network)
       (send-packets (collect-packets network))
       (loop)))))

(define (runB)
  (call/cc
   (lambda (done)
     (define network (cat6-network))
     (define nat-y #f)
     (define nat #f)
     (define (check-idle)
       (define idle? #t)
       (vector-for-each (lambda (nic)
                          (unless (null? (nic 'peek-in))
                            (set! idle? #f)))
                        network)
       (when idle?
         (let ((y (cadr nat)) (nic (vector-ref network 0)))
           (when (and nat-y (= nat-y y)) (done y)) ;; first repeat
           (set! nat-y y)
           (send-input* nic nat))))
     (define (send-packets Q)
       (if (null? Q)
           (feed--1 network) 
           (let send ((Q Q))
             (match Q
               ((255 x y Q ...)
                (set! nat (list x y))
                (send Q))
               ((a x y Q ...)
                (send-input* (vector-ref network a) (list x y))
                (send Q))
               (() (check-idle))))))
     (let loop ()
       (run-network network)
       (send-packets (collect-packets network))
       (loop)))))
