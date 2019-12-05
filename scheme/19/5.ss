(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 5)

(define (run . intcode)
  (apply reset! intcode)
  (let loop ((ip 0))
    (let ((ip* (step ip)))
      (unless (= ip ip*)
        (loop (step ip*)))))
  (out))

(define (step ip)
  (let ((op (fetch ip)))
    (case (mod op 100)
      ((1)
       (store! (fetch (+ ip 3))
               (+ (ref ip op 1)
                  (ref ip op 2)))
       (+ ip 4))
      ((2)
       (store! (fetch (+ ip 3))
               (* (ref ip op 1)
                  (ref ip op 2)))
       (+ ip 4))
      ((3)
       (store! (fetch (+ ip 1))
               (in))
       (+ ip 2))
      ((4)
       (out (ref ip op 1))
       (+ ip 2))
      ((5)
       (if (zero? (ref ip op 1))
           (+ ip 3)
           (ref ip op 2)))
      ((6)
       (if (zero? (ref ip op 1))
           (ref ip op 2)
           (+ ip 3)))
      ((7)
       (store! (fetch (+ ip 3))
               (if (< (ref ip op 1)
                      (ref ip op 2))
                   1
                   0))
       (+ ip 4))
      ((8)
       (store! (fetch (+ ip 3))
               (if (= (ref ip op 1)
                      (ref ip op 2))
                   1
                   0))
       (+ ip 4))
      ((99) ip)
      (else (error 'run "bad opcode" op)))))

;; opcode lib
(define in
  (make-parameter 1))

(define out
  (make-parameter 0))

(define intcode
  (parse-advent comma-separated))

(define memory
  (list->vector intcode))

(define (ref ip opcode param)
  (let ((mode (mod (quotient opcode (expt 10 (1+ param))) 10)))
    (if (zero? mode)
        (val (+ ip param))
        (fetch (+ ip param)))))

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
