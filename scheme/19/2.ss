(include "~/code/advent/load.ss")
(advent-year 19)
(advent-day 2)

;; machine a
(define (part-a)
  (seed! 12 2)
  (machine)
  (display-ln (out)))

(define (part-b)
  (call/cc
   (lambda (exit)
     (do ((i 0 (1+ i)))
         ((= i 100))
       (do ((j 0 (1+ j)))
           ((= j 100))
         (seed! i j)
         (machine)
         (when (= 19690720 (out))
           (exit (+ (* 100 i) j))))))))

(define (seed! a b)
  (reset!)
  (store! 1 a)
  (store! 2 b))

(define (machine)
  (let run ((ip 0))
    (when (match (fetch ip)
            (1 (store! (fetch (+ ip 3))
                       (+ (val (+ ip 1))
                          (val (+ ip 2))))
               'continue)
            (2 (store! (fetch (+ ip 3))
                       (* (val (+ ip 1))
                          (val (+ ip 2))))
               'continue)
            (99 #f)
            (else (error 'run "bad opcode" (fetch ip))))
      (run (+ ip 4)))))

;; opcode lib
(define intcode
  (parse-advent comma-separated))
(define mem
  (list->vector intcode))
(define (fetch addr)
  (vector-ref mem addr))
(define (val addr)
  (fetch (fetch addr)))
(define (store! addr val)
  (vector-set! mem addr val))
(define reset!
  (case-lambda
    (() (set! mem (list->vector intcode)))
    ((intcode) (set! mem (list->vector intcode)))))
(define (out)
  (fetch 0))

