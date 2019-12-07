(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 7)

(define eg

  ;;  '(3 15 3 16 1002 16 10 16 1 16 15 15 4 15 99 0 0)
  ;; '(3 31 3 32 1002 32 10 32 1001 31 -2 31 1007 31 0 33 1002 33 7 33 1 33 31 31 1 32 31 31 4 31 99 0 0 0)
  ;;  '(3 23 3 24 1002 24 10 24 1002 23 -1 23 101 5 23 23 1 24 23 23 4 23 99 0 0)
  )

(define update? #f)

;; program runs... first input
;; two inputs

(define (main)
  (let ((best 0))
    (for-all (lambda (abcde)
               (run* abcde)
               (when (< best (out))
                 ;;                 (display-ln (cons abcde (out)))
                 (set! best (out))))
             (permutations (iota 5)))
    best))

(define (run* phases)
  (set! update? #f)
  (phase-in (car phases))
  (in 0)
  (run)
  (let loop ((phases (cdr phases)))
    (unless (null? phases)
      (set! update? #f)
      (in (out))
      (phase-in (car phases))
      (run)
      (loop (cdr phases)))))

(define (run)
  (reset!)
  (let loop ((ip 0))
    (let ((ip* (step ip)))
      (unless (= ip ip*)
        (loop (step ip*))))))

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
       (let ((sig (if update?
                      (in)
                      (begin
                        (set! update? #t)
                        (phase-in)))))
         
         (store! (fetch (+ ip 1)) sig)
         (+ ip 2)))
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
  (make-parameter 0))

(define phase-in
  (make-parameter 0))

(define out
  (make-parameter 0))

(define intcode

  ;;
  (parse-advent comma-separated)
  )

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

