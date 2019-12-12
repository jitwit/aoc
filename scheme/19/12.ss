(load "~/code/advent/load.ss")
(advent-day 12)

(import (except (scmutils base) s:ref)
        (scmutils generic))

(define input (parse-advent input-chars))

(define moons
  '(#(3 2 -6)
    #(-13 18 10)
    #(-8 -1 13)
    #(5 10 4)))

(define (make m)
  `(,m #(0 0 0)))

(define (potential m)
  (apply + (vector->list (vector-map abs (car m)))))

(define (kinetic m)
  (apply + (vector->list (vector-map abs (cadr m)))))

(define (energy m)
  (* (kinetic m) (potential m)))

(define pos car)
(define vel cadr)

(define (step-moon m ms)
  (let* ((ms (remove m ms))
         (dv  (apply + (map (lambda (n)
                              (vector-map sign (- (pos n) (pos m))))
                            ms))))
    `(,(+ dv (pos m) (vel m))
      ,(+ dv (vel m)))))

(define state0
  (map make moons))

(define (evolve moons)
  (map (lambda (m) (step-moon m moons))
       moons))

(define (part-a)
  (apply + (map energy (s:ref (s:iter evolve state0) 1000))))

(define (isolate axis state)
  (map (lambda (moon)
         (map (lambda (p/v)
                (vector-ref p/v axis))
              moon))
       state))

(define (period axis)
  (define seen (make-hashtable equal-hash equal?))
  (let loop ((i 0) (state state0))
    (let ((current (isolate axis state)))
      (or (and (hashtable-ref seen current #f)
               i)
          (begin
            (hashtable-set! seen current #t)
            (loop (1+ i) (evolve state)))))))

(define (part-b)
  (apply lcm (map period '(0 1 2))))

;; i from 0 to 3, j is 0 or 1, k from 0 to 2
(define (%isolate moon pos/vel x/y/z)
  (lambda (ms)
    (vector-ref (list-ref (list-ref ms moon)
                          pos/vel)
                x/y/z)))

