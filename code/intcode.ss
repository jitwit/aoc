(define (intcode program)
  (define ip 0)
  (define relative-base 0)
  (define status 'ok)
  (define cache1 `#(,@program))
  (define cache2 (make-eq-hashtable))
  (define size (vector-length cache1))
  (define in '())
  (define out '())

  (define (ip! dx)
    (set! ip (+ ip dx)))

  (define (rb! dx)
    (set! relative-base (+ relative-base dx)))
  
  (define (store! addr val)
    (if (fx< addr size)
        (vector-set! cache1 addr val)
        (hashtable-set! cache2 addr val)))
  
  (define (ref addr)
    (if (fx< addr size)
        (vector-ref cache1 addr)
        (hashtable-ref cache2 addr 0)))
  
  (define (val opcode param)
    (case (digit-at param opcode)
      ((1) (ref (+ ip param)))
      ((2) (ref (+ relative-base (ref (+ ip param)))))
      ((0) (ref (ref (+ ip param))))))

  (define (addr opcode param)
    (case (digit-at param opcode)
      ((2) (+ relative-base (ref (+ ip param))))
      ((0) (ref (+ ip param)))
      ((1) (error 'machine-addr "addr is immediate" opcode param))))
  
  (define (step)
    (let ((op (ref ip)))
      (case (fxmod op 100)
        ((1) (store! (addr op 3) (+ (val op 1) (val op 2))) (ip! 4))
        ((2) (store! (addr op 3) (* (val op 1) (val op 2))) (ip! 4))
        ((3) (if (null? in) (set! status 'blocking-in)
                 (begin (set! status 'ok) (store! (addr op 1) (pop! in)) (ip! 2))))
        ((4) (set! status 'out) (push! (val op 1) out) (ip! 2))
        ((5) (if (zero? (val op 1)) (ip! 3) (set! ip (val op 2))))
        ((6) (if (zero? (val op 1)) (set! ip (val op 2)) (ip! 3)))
        ((7) (store! (addr op 3) (if (< (val op 1) (val op 2)) 1 0)) (ip! 4))
        ((8) (store! (addr op 3) (if (= (val op 1) (val op 2)) 1 0)) (ip! 4))
        ((9) (rb! (val op 1)) (ip! 2))
        ((99) (set! status 'done))
        (else (error 'intcode "bad opcode" op)))))

  (define (reset!)
    (set! cache1 `#(,@program))
    (set! cache2 (make-eq-hashtable))
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
      ((read-out!) (let ((tmp (reverse out))) (set! out '()) tmp))
      ((status) status)
      ((mem) (if (null? args) (mem) (apply ref args)))
      ((ip) ip)
      ((rb) relative-base)
      ((ref) (apply ref args))
      ((reset!) (reset!))
      ((set-mem!) (apply store! args))
      ((cache1) cache1)
      ((cache2) cache2)
      ((peek-in) in)
      ((peek-out) (reverse out))
      ((intcode) program)
      (else (error 'cpu "unknown message" me)))))

(define (read-memory M addr)
  (M 'mem addr))

(define (store! M addr val)
  (M 'set-mem! addr val))

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
