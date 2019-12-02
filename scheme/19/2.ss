(include "~/code/advent/load.ss")
(advent-year 19)
(advent-day 2)

(define (part-a)
  (reset!)
  (seed! 12 2)
  (machine)
  (out))

(define (part-b)
  (call/cc
   (lambda (exit)
     (do ((i 0 (fx1+ i)))
         ((fx= i 100))
       (do ((j 0 (fx1+ j)))
           ((fx= j 100))
         (reset!)
         (seed! i j)
         (machine)
         (when (fx= 19690720 (out))
           (exit (fx+ (fx* 100 i) j))))))))

(define (seed! a b)
  (store! 1 a)
  (store! 2 b))

(define (machine)
  (let run ((ip 0))
    (when (match (fetch ip)
            (1 (store! (fetch (fx+ ip 3))
                       (fx+ (val (fx+ ip 1))
                            (val (fx+ ip 2))))
               'continue)
            (2 (store! (fetch (fx+ ip 3))
                       (fx* (val (fx+ ip 1))
                            (val (fx+ ip 2))))
               'continue)
            (99 #f)
            (else (error 'run "bad opcode" (fetch ip))))
      (run (fx+ ip 4)))))

;; opcode lib
(define intcode
  (parse-advent comma-separated))
(define memory
  (list->vector intcode))
(define (fetch addr)
  (vector-ref memory addr))
(define (val addr)
  (fetch (fetch addr)))
(define (store! addr val)
  (vector-set! memory addr val))
(define reset!
  (case-lambda
    (() (set! memory (list->vector intcode)))
    ((intcode) (set! memory (list->vector intcode)))))
(define (out)
  (fetch 0))

