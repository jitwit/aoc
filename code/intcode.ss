(define (intcode program)
  (define ip 0)
  (define relative-base 0)
  (define status 'ok)
  (define memory-1 `#(,@program))
  (define memory-2 (make-eq-hashtable))
  (define size (vector-length memory-1))
  (define in '())
  (define out '())
  (define max-ref 0)

  (define (ip! dx)
    (set! ip (fx+ ip dx)))

  (define (rb! dx)
    (set! relative-base (fx+ relative-base dx)))
  
  (define (store! addr val)
    (if (fx< addr size)
        (vector-set! memory-1 addr val)
        (hashtable-set! memory-2 addr val)))
  
  (define (ref addr)
    (set! max-ref (max max-ref addr))
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
      ((1) (error 'machine-addr "addr is immediate" opcode param))))
  
  (define (step)
    (let ((op (ref ip)))
      (case (fxmod op 100)
        ((1) (store! (addr op 3) (fx+ (val op 1) (val op 2))) (ip! 4))
        ((2) (store! (addr op 3) (fx* (val op 1) (val op 2))) (ip! 4))
        ((3) (if (null? in) (set! status 'blocking-in)
                 (begin (set! status 'ok) (store! (addr op 1) (pop! in)) (ip! 2))))
        ((4) (set! status 'out) (push! (val op 1) out) (ip! 2))
        ((5) (if (fxzero? (val op 1)) (ip! 3) (set! ip (val op 2))))
        ((6) (if (fxzero? (val op 1)) (set! ip (val op 2)) (ip! 3)))
        ((7) (store! (addr op 3) (if (fx< (val op 1) (val op 2)) 1 0)) (ip! 4))
        ((8) (store! (addr op 3) (if (fx= (val op 1) (val op 2)) 1 0)) (ip! 4))
        ((9) (rb! (val op 1)) (ip! 2))
        ((99) (set! status 'done))
        (else (error 'intcode "bad opcode" op)))))

  (define (reset!)
    (set! memory-1 `#(,@program))
    (set! memory-2 (make-eq-hashtable))
    (set! ip 0)
    (set! relative-base 0)
    (set! in '())
    (set! out '())
    (set! status 'ok))

  (lambda (me . args)
    (case me
      ((step) (set! status 'ok) (step) status)
      ((in) (set! in `(,@in ,@args)) (set! status 'ok))
      ((out) (if (null? out) 'no-out (car out)))
      ((status) status)
      ((read-out!) (let ((tmp (reverse out))) (set! out '()) tmp))
      ((peek-in) in)
      ((ip) ip)
      ((rb) relative-base)
      ((ref) (apply ref args))
      ((store!) (apply store! args))
      ((reset!) (reset!))
      ((program) program)
      ((max-ref) max-ref)
      (else (error 'cpu "unknown message" me)))))

(define (read-memory M addr)
  (M 'ref addr))

(define (store! M addr val)
  (M 'store! addr val))

(define (reset! M)
  (M 'reset!))

(define (step M)
  (M 'step))

(define (run M)
  (M 'run))

(define (send-input M value)
  (M 'in value))

(define (send-input* M values)
  (apply M 'in values))

(define (read-output M)
  (M 'read-out!))

(define (get-input M)
  (M 'peek-in))

(define (get-output M)
  (M 'out))

(define (status M)
  (M 'status))

(define (run-until status M)
  (let run ((s (step M)))
    (if (memq s status) s (run (step M)))))

(define (run-until-halt M)
  (run-until '(done blocking-in) M))

(define (halt M)
  (run-until '(done blocking-in) M))

(define (done? M)
  (eq? 'done (status M)))

(define (blocked? M)
  (eq? 'blocking-in (status M)))

(define (run-intcode program . inputs)
  (define M (intcode program))
  (apply M 'in inputs)
  (run-until-halt M)
  (read-output M))
