(load "~/code/advent/load.ss")

(define intcode-13
  (parameterize ((advent-year 19) (advent-day 13))
    (parse-advent comma-separated)))

(define empty 0)
(define (empty? x) (= empty x))
(define wall 1)
(define (wall? x) (= wall x))
(define block 2)
(define (block? x) (= block x))
(define horizontal-paddle 3)
(define (horizontal-paddle? x) (= horizontal-paddle x))
(define ball 4)
(define (ball? x) (= ball x))

(define (paint screen m)
  (define score)
  (let loop ((instructions (read-output m)))
    (match instructions
      ((-1 0 x instructions ...)
       (set! score x)
       (loop instructions))
      ((x y pixel instructions ...)
       (hashtable-set! screen (make-rectangular x y) pixel)
       (loop instructions))
      (else score))))

(define (locate object screen)
  (filter-map (lambda (z.o)
                (and (= (cdr z.o) object)
                     (car z.o)))
              (vector->list (hashtable-cells screen))))

(define (ball-location screen)
  (car (locate ball screen)))

(define (paddle-location screen)
  (car (locate horizontal-paddle screen)))

(define (update screen machine)
  (run-until-halt machine)
  (paint screen machine))

(define (partA)
  (define m (cpu intcode-13))
  (define screen (make-eqv-hashtable))
  (update screen m)
  (length (locate block screen)))

(define (partB)
  (define m (cpu intcode-13))
  (define screen (make-eqv-hashtable))
  (store! m 0 2)
  (let run ()
    (let ((score (update screen m)))
      (if (done? m)
          score
          (let ((b (real-part (ball-location screen)))
                (p (real-part (paddle-location screen))))
            (send-input m (sign (- b p)))
            (run))))))
