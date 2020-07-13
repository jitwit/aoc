(load "~/code/aoc/load.ss")

(advent-day 23)
(advent-year 19)

(define program
  (parse-advent parse-intcode))

(define cat6-size 50)

(define (cat6-network program)
  (define V (make-vector cat6-size))
  (do ((i 0 (1+ i)))
      ((= i cat6-size) V)
    (let ((nic (intcode program)))
      (send-input nic i)
      (run-until-halt nic)
      (vector-set! V i nic))))

(define (run-network network)
  (vector-for-each run-until-halt network))

(define (feed--1 network)
  (vector-for-each (lambda (nic) (send-input nic -1)) network))

(define (collect-packets network)
  (run-network network)
  (let scan ((i 0) (packets '()))
    (if (= i cat6-size)
        packets
        (scan (1+ i) (append (read-output (vector-ref network i)) packets)))))

(define (partA)
  (call/cc
   (lambda (done)
     (define network (cat6-network program))
     (define (send-packets Q)
       (if (null? Q)
           (feed--1 network)
           (let send ((Q Q))
             (match Q
               ((255 _ y z ...)
                (done y))
               ((a x y z ...)
                (send-input (vector-ref network a) x y)
                (send z))
               (() (void))))))
     (let loop ()
       (send-packets (collect-packets network))
       (loop)))))

(define (partB)
  (call/cc
   (lambda (done)
     (define network (cat6-network program))
     (define nat-y #f)
     (define nat #f)
     (define (check-idle)
       (define idle? #t)
       (vector-for-each (lambda (nic)
                          (unless (null? (get-input nic))
                            (set! idle? #f)))
                        network)
       (when idle?
         (let ((y (cadr nat)) (nic (vector-ref network 0)))
           (when (and nat-y (= nat-y y)) (done y)) ;; first repeat
           (set! nat-y y)
           (send-input nic nat))))
     (define (send-packets Q)
       (if (null? Q)
           (feed--1 network) 
           (let send ((Q Q))
             (match Q
               ((255 x y Q ...)
                (set! nat (list x y))
                (send Q))
               ((addr x y Q ...)
                (send-input (vector-ref network addr) x y)
                (send Q))
               (() (check-idle))))))
     (let loop ()
       (send-packets (collect-packets network))
       (loop)))))
