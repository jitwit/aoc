(optimize-level 3)
(load "~/code/aoc/load.ss")
(advent-year 20) (advent-day 23)

(define cups
  (digits (car (parse-advent input))))

(define (follow ring ix)
  (fxvector-ref ring ix))

(define (pointer ring)
  (follow ring 0))

(define (point! ring u v)
  (fxvector-set! ring u v))

(define (input->ring cups)
  ;; store current pointer at 0 index. ptrs[i] gives link i->j.
  (define ring (make-fxvector (fx1+ (length cups))))
  (for-each (lambda (u v)
	      (point! ring u v))
	    cups
	    `(,@(cdr cups) ,(car cups)))
  (fxvector-set! ring 0 (car cups))
  ring)

(define (destination ring target taken)
  (let lp ((option target) (tries 0))
    (cond ((zero? option) (lp (fx1- (fxvector-length ring)) 0))
	  ((or (fx= tries 3) (not (memq option taken))) option)
	  (else (lp (fx1- option) (fx1+ tries))))))

(define (evolve ring)
  (define current (pointer ring))
  (define chain-1 (follow ring current))
  (define chain-2 (follow ring chain-1))
  (define chain-3 (follow ring chain-2))
  (define chain-e (follow ring chain-3))
  (define chain-d (destination ring (fx1- current) `(,chain-1 ,chain-2 ,chain-3)))
  (define chain-n (follow ring chain-d))
  (point! ring current chain-e)
  (point! ring chain-d chain-1)
  (point! ring chain-3 chain-n)
  (point! ring 0 chain-e))

(define (crab-cup seed times)
  (define ring (input->ring seed))
  (do ((i 0 (fx1+ i)))
      ((= i times) ring)
    (evolve ring)))

(define (part-a)
  (define cup (crab-cup cups 100))
  (do ((i (fx- (fxvector-length cup) 2) (fx1- i))
       (p (follow cup 1) (follow cup p))
       (x 0 (+ (* x 10) p)))
      ((fxzero? i) x)))

(define (part-b)
  (define cup
    (crab-cup `(,@cups ,@(list-tail (iota (1+ (expt 10 6)))
				    10))
	      (expt 10 7)))
  (* (follow cup 1) (follow cup (follow cup 1))))
