(load "~/code/aoc/load.ss")
(advent-year 24) (advent-day 17)

;; ip increases by 2 except jumps
;; 0-3 represent literals
;; 4-6 take values from registers a,b,c

;; opcodes
;; adv    0: division numerator reg A denominator is 2^ combo operand... stored to A
;; bxl    1: bitwise xor of B and instructions literal stored to B
;; bst    2: combo operand mod 8 => B
;; jnz    3: if A is 0 nothing, otherwise ip takes value of literal operand
;; bxc    4: xor of B & C => B
;; out    5: combo mod 8 output that value
;; bdv    6: like adv but with reg B
;; cdv    7: like adv but with reg C

;(define program '#(0 1 5 4 3 0))
;(define program '#(2 4 1 1 7 5 0 3 1 4 4 4 5 5 3 0))
;(define A 729)
;(define A 30886132)
;(define B 0)
;(define C 0)
;(define ip 0)
;(define out '())
;
(define (run seed program)
  (define A seed)
  (define B 0)
  (define C 0)
  (define ip 0)
  (define out '())
  (define (operand->value x)
    (case x
      ((4) A)
      ((5) B)
      ((6) C)
      ((7) (error 'operand->value "invalid program"))
      (else x)))
  (define (operand)
    (vector-ref program (1+ ip)))
  (define (combo-operand)
    (operand->value (operand)))
  (define (literal-operand)
    (operand))
  (define (output x)
    (set! out (cons x out)))
  (define (step)
    (case (vector-ref program ip)
      ((0)
       (set! A (ash A (- (combo-operand))))
       (set! ip (+ ip 2)))
      ((1)
       (set! B (logxor B (literal-operand)))
       (set! ip (+ ip 2)))
      ((2)
       (set! B (logand 7 (combo-operand)))
       (set! ip (+ ip 2)))
      ((3)
       (cond ((zero? A)
	      (set! ip (+ ip 2)))
	     (else
	      (set! ip (literal-operand)))))
      ((4)
       (set! B (logxor B C))
       (set! ip (+ ip 2)))
      ((5)
       (output (mod (combo-operand) 8))
       (set! ip (+ ip 2)))
      ((6)
       (set! B (ash A (- (combo-operand))))
       (set! ip (+ ip 2)))
      ((7)
       (set! C (ash A (- (combo-operand))))
       (set! ip (+ ip 2)))))
  (let lp ()
    (cond ((< -1 ip (vector-length program))
	   (step)
	   (lp))
	  (else
	   (string-join (map number->string (reverse out))
			",")))))

(define (fixpoint seed program best dx)
  (call/cc
   (lambda (k)
     (define A seed)
     (define B 0)
     (define C 0)
     (define ip 0)
     (define out '())
     (define (operand->value x)
       (case x
	 ((4) A)
	 ((5) B)
	 ((6) C)
	 ((7) (error 'operand->value "invalid program"))
	 (else x)))
     (define (operand)
       (vector-ref program (1+ ip)))
     (define (combo-operand)
       (operand->value (operand)))
     (define (literal-operand)
       (operand))
     (define (output x)
       (set! out (cons x out)))
     (define (step)
       (case (vector-ref program ip)
	 ((0)
	  (set! A (ash A (- (combo-operand))))
	  (set! ip (+ ip 2)))
	 ((1)
	  (set! B (logxor B (literal-operand)))
	  (set! ip (+ ip 2)))
	 ((2)
	  (set! B (logand 7 (combo-operand)))
	  (set! ip (+ ip 2)))
	 ((3)
	  (cond ((zero? A)
		 (set! ip (+ ip 2)))
		(else
		 (set! ip (literal-operand)))))
	 ((4)
	  (set! B (logxor B C))
	  (set! ip (+ ip 2)))
	 ((5)
	  (output (mod (combo-operand) 8))
	  (set! ip (+ ip 2))
	  (cond ((and (<= (length out) (vector-length program))
		      (equal? (reverse out) (list-head (vector->list program) (length out))))
		 (when (< best (length out)) ; so far so good
		   (set! best (length out))
		   (format #t "~a ~a ~a~%" seed (octal seed) (reverse out))))
		((equal? (reverse out) (vector->list program))
		 (k seed))
		(else ;; need better way to search...
		 (k (fixpoint (+ seed dx) program best dx)))))
	 ((6)
	  (set! B (ash A (- (combo-operand))))
	  (set! ip (+ ip 2)))
	 ((7)
	  (set! C (ash A (- (combo-operand))))
	  (set! ip (+ ip 2)))))
     (let lp ()
       (cond ((< -1 ip (vector-length program))
	      (step)
	      (lp))
	     (else
	      (if (equal? (reverse out) (vector->list program))
		  (k seed)
		  (k (fixpoint (+ seed dx) program best dx)))))))))

(define (octal x)
  (let lp ((x x) (ys '()))
    (if (zero? x)
	ys
	(let-values (((q r) (div-and-mod x 8)))
	  (lp q (cons r ys))))))

(define p1 '#(0 3 5 4 3 0))
(define p2 '#(2 4 1 1 7 5 0 3 1 4 4 4 5 5 3 0))

(define (go)
  (run 117440 '#(0 3 5 4 3 0)))

(define (gogo)
  (run 30886132 '#(2 4 1 1 7 5 0 3 1 4 4 4 5 5 3 0)))

;; process to find call (fixpoint x p2 0 `octal length of x`) where x
;; is previous best solution found... works ish?
