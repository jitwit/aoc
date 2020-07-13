#lang racket

(require racket/unsafe/ops
	 racket/fixnum)

(provide ; provisions
         step              ; small step
         intcode-ref       ; read intcode memory at address
         intcode-set!      ; set  intcdoe memory at address to value
         send-input        ; send list of values to intcode
         read-output       ; read outputs of intcode, popping them
         peek-output       ; read last output of intcode, leaving unchanged
         run-until         ; run intcode until given state is reacned
         run-until-halt    ; (run-until '(blocked done) machine)
         done?             ; (eq? 'done (status machine))
         blocked?          ; (eq? blocked (status machine))
         parse-intcode     ; parse a port containing comma-separated ints
         intcode           ; create an intcode from a list of ints
         run-intcode       ; run an intcode program given by vector of ints and given inputs
         fork-intcode      ; copy an intcode's state to a new intcode
         reset-intcode     ; reset an intcode's state
	 )

(define (intcode program)
  (define ip 0)                           ; instruction pointer
  (define relative-base 0)                ; offset pointer
  (define memory-1 (vector-copy program)) ; memory (also initially the program)
  (define memory-2 (make-eq-hashtable))   ; extra memory for out of range references
  (define in '())                         ; input signals
  (define out '())                        ; output signals
  (define size (vector-length memory-1))  ; size (for use in indexing)

  (define reset!
    (case-lambda
      (()
       (set! memory-1 (vector-copy program))
       (set! memory-2 (make-eq-hashtable))
       (set! ip 0)
       (set! relative-base 0)
       (set! in '())
       (set! out '()))
      ((m1* m2* ip* rb* in* out* status*)
       (set! memory-1 m1*)
       (set! memory-2 m2*)
       (set! ip ip*)
       (set! relative-base rb*)
       (set! in in*)
       (set! out out*))))

  (define (ip! dx)
    (set! ip (fx+ ip dx)))
  
  (define (rb! dx)
    (set! relative-base (fx+ relative-base dx)))

  (define (store! addr val)
    (if (fx< addr size)
        (vector-set! memory-1 addr val)
        (hashtable-set! memory-2 addr val)))
  
  (define (ref addr)
    (if (fx< addr size)
        (vector-ref memory-1 addr)
        (hashtable-ref memory-2 addr 0)))

  (define (val opcode param)
    (case (digit-at param opcode)
      ((1) (ref (fx+ ip param)))
      ((2) (ref (fx+ relative-base (ref (fx+ ip param)))))
      ((0) (ref (ref (fx+ ip param))))))
  
  (define (addr opcode param)
    (case (digit-at param opcode)
      ((2) (fx+ relative-base (ref (fx+ ip param))))
      ((0) (ref (fx+ ip param)))
      ((1) (error 'intcode "addr is immediate" opcode param))))

  (define (step)
    (let ((op (ref ip)))
      (case (fxmod op 100)
        ((1) (store! (addr op 3) (fx+ (val op 1) (val op 2))) (ip! 4) 'ok)
        ((2) (store! (addr op 3) (fx* (val op 1) (val op 2))) (ip! 4) 'ok)
        ((3) (if (null? in)
  	       'blocked
                 (begin (store! (addr op 1) (pop! in)) (ip! 2) 'ok)))
        ((4) (push! (val op 1) out) (ip! 2) 'out)
        ((5) (if (fxzero? (val op 1)) (ip! 3) (set! ip (val op 2))) 'ok)
        ((6) (if (fxzero? (val op 1)) (set! ip (val op 2)) (ip! 3)) 'ok)
        ((7) (store! (addr op 3) (if (fx< (val op 1) (val op 2)) 1 0)) (ip! 4) 'ok)
        ((8) (store! (addr op 3) (if (fx= (val op 1) (val op 2)) 1 0)) (ip! 4) 'ok)
        ((9) (rb! (val op 1)) (ip! 2) 'ok)
        ((99) 'done)
        (else (error 'intcode "bad opcode" op)))))

  (lambda (me . args)
    (case me
      ((step) (step))
      ((in) (set! in `(,@in ,@args)) 'ok)
      ((peek-out) (and (not (null? out)) (car out)))
      ((read-out!) (let ((tmp (reverse out))) (set! out '()) tmp))
      ((ref) (apply ref args))
      ((set!) (apply store! args))
      ((reset!) (apply reset! args))
      ((program) program)
      ((core-dump) (list program memory-1 memory-2 ip relative-base in out))
      (else (error 'cpu "unknown message" me)))))

(define (parse-intcode . port)
  (define in (if (null? port) (current-input-port) (car port)))
  (list->vector (map string->number (string-split (read-line in) ","))))

(define (intcode-ref M addr)
  (M 'ref addr))

(define (intcode-set! M addr val)
  (M 'set! addr val))

(define (reset-intcode M)
  (M 'reset!))

(define (step M)
  (M 'step))

(define (send-input M . values)
  (apply M 'in values))

(define (read-output M)
  (M 'read-out!))

(define (peek-output M)
  (M 'peek-out))

(define (run-until status M)
  (let run ((s (step M)))
    (if (memq s status) s (run (step M)))))

(define (run-until-halt M)
  (run-until '(done blocked) M))

(define (done? M)
  (eq? 'done (step M)))

(define (blocked? M)
  (eq? 'blocked (step M)))

(define (core-dump M)
  (M 'core-dump))

(define (fork-intcode M)
  (apply (lambda (p m1 m2 i r in out)
	   (define M* (intcode p))
	   (M* 'reset! (vector-copy m1) (hashtable-copy m2 #t) i r in out)
	   M*)
	 (core-dump M)))

(define (run-intcode program . input)
  (define M (intcode program))
  (apply M 'in input)
  (run-until-halt M)
  (read-output M))

(define fxmod unsafe-fxmodulo)
(define fx/ unsafe-fxquotient)
(define fx+ unsafe-fx+)
(define fx* unsafe-fx*)
(define make-eq-hashtable make-hasheq)
(define hashtable-set! hash-set!)
(define hashtable-ref hash-ref)
(define (fxzero? x)
  (unsafe-fx= 0 x))
(define (hashtable-copy T mut?)
  (hash-copy T))

(define-syntax push!
  (lambda (x)
    (syntax-case x ()
      ((_ x xs)
       #'(set! xs (cons x xs))))))

(define-syntax pop!
  (lambda (x)
    (syntax-case x ()
      ((_ xs)
       #'(let ((x (car xs)))
	   (set! xs (cdr xs))
	   x)))))

(define (digit-at i n)
  (fxmod (fx/ n (expt 10 (fx+ i 1))) 10))
