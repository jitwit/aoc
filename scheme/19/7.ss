(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 7)

(define eg1
  '(3 15 3 16 1002 16 10 16 1 16 15 15 4 15 99 0 0))

(define eg2
  '(3 31 3 32 1002 32 10 32 1001 31 -2 31 1007 31 0 33 1002 33 7 33 1 33 31 31 1 32 31 31 4 31 99 0 0 0))

(define eg3
  '(3 23 3 24 1002 24 10 24 1002 23 -1 23 101 5 23 23 1 24 23 23 4 23 99 0 0))

(define intcode
  (parse-advent comma-separated))

(define (feed M N id)
  (lambda ()
    (let run ()
      (case (M 'status)
        ((out) (N 'in (M 'out)) 'out)
        ((no-in) 'blocked)
        ((done) 'done)
        (else (M 'step) (run))))))

(define (exhaust M id)
  (lambda ()
    (let run ()
      (M 'step)
      (case (M 'status)
        ((done) 'done)
        ((out no-in) 'blocked)
        (else (run))))))

(define (run-day7 phase-settings)
  (define A (machine intcode 0))
  (define B (machine intcode 0))
  (define C (machine intcode 0))
  (define D (machine intcode 0))
  (define E (machine intcode 0))
  (define machines
    (list A B C D E))
  (define loop
    (list (feed A B 'A->B)
          (feed B C 'B->C)
          (feed C D 'C->D)
          (feed D E 'D->E)
          (feed E A 'E->A)
          (exhaust A 'A)
          (exhaust B 'B)
          (exhaust C 'C)
          (exhaust D 'D)
          (exhaust E 'E)))
  
  (for-all (lambda (M phase)
             (M 'in phase))
           machines
           phase-settings)

  (A 'in 0)
  
  (let run ()
    (case (E 'status)
      ((done) (E 'dump))
      (else
       (let ((action (pop! loop)))
         (let ((result (action)))
           (set! loop `(,@loop ,action))
           (run)))))))

(define (partA)
  (define best 0)
  (for-all (lambda (phase-settings)
             (let ((out (car (run-day7 phase-settings))))
               (when (< best out)
                 (set! best (max best out)))))
           (permutations '(0 1 2 3 4)))
  best)

(define (partB)
  (define best 0)
  (for-all (lambda (phase-settings)
             (let ((out (car (run-day7 phase-settings))))
               (when (< best out)
                 (set! best (max best out)))))
           (permutations '(5 6 7 8 9)))
  best)
