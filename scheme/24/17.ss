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

(define program '#(0 1 5 4 3 0))
(define program '#(2 4 1 1 7 5 0 3 1 4 4 4 5 5 3 0))
(define A 729)
(define A 30886132)
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

(define (operand ip)
  (vector-ref program (1+ ip)))

(define (combo-operand ip)
  (operand->value (operand ip)))

(define (literal-operand ip)
  (operand ip))

(define (output x)
  (set! out (cons x out)))

(define (step)
  (case (vector-ref program ip)
    ((0)
     (set! A (ash A (- (combo-operand ip))))
     (set! ip (+ ip 2)))
    ((1)
     (set! B (logxor B (literal-operand ip)))
     (set! ip (+ ip 2)))
    ((2)
     (set! B (logand 7 (combo-operand ip)))
     (set! ip (+ ip 2)))
    ((3)
     (cond ((zero? A)
	    (set! ip (+ ip 2)))
	   (else
	    (set! ip (literal-operand ip)))))
    ((4)
     (set! B (logxor B C))
     (set! ip (+ ip 2)))
    ((5)
     (output (mod (combo-operand ip) 8))
     (set! ip (+ ip 2)))
    ((6)
     (set! B (ash A (- (combo-operand ip))))
     (set! ip (+ ip 2)))
    ((7)
     (set! C (ash A (- (combo-operand ip))))
     (set! ip (+ ip 2)))))

(define (run)
  (display-state)
  (let lp ()
    (cond ((< -1 ip (vector-length program))
	   (step)
	   (display-state)
	   (lp))
	  (else
	   (display-output)))))

(define (display-state)
  (format #t "reg A: ~a~%reg B: ~a~%reg C: ~a~%ip: ~a~%out: ~a~%~%" A B C ip (reverse out)))

(define (display-output)
  (string-join (map number->string (reverse out))
	       ","))
