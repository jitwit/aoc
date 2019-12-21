(load "~/code/advent/load.ss")

(define intcode
  (parse-advent comma-separated))

(define m (cpu intcode))

(define (showme M)
  (for-all (compose display integer->char) (read-output M)))

(define (spring-it program)
  (define M (cpu intcode))
  (apply M 'in (map char->integer (string->list (stmts->string program))))
  (run-until-halt M)
  (showme M))

(define (spring-script program)
  (call/cc
   (lambda (woot)
     (with-exception-handler
         (lambda (e)
           (when (eq? (condition-who e) 'integer->char)
             (woot (car (condition-irritants e)))))
       (lambda ()
         (spring-it program))))))

(define spring-codes
  '(not and or))

(define regs-out
  '(t j))

(define regs-a
  '(a b c d))

(define (stmt->string stmt)
  (let ((pieces (intersperse " " (map symbol->string stmt))))
    (string-upcase (string-append (apply string-append pieces) "\n"))))

(define (stmts->string program)
  (apply string-append (map stmt->string program)))

(define (blindly l n)
  (possible-statements)
  (do ((i 0 (1+ i))
       (prog (random-prog l) (random-prog l)))
      ((= i n))
    (display-ln (cons i prog))
    (spring-script (output prog))))

(define statements '())

(define (possible-statements)
  (define stmts '())
  (do ((ops spring-codes (cdr ops)))
      ((null? ops) (set! statements stmts) stmts)
    (do ((r1 (append regs-a regs-out) (cdr r1)))
        ((null? r1))
      (do ((r2 regs-out (cdr r2)))
          ((null? r2))
        (push! (list (car ops) (car r1) (car r2)) stmts)))))

(define (random-prog n)
  (do ((prog '((walk)) (cons (random-element statements) prog))
       (i 0 (1+ i)))
      ((= i n) prog)))

(define (random-element lst)
  (list-ref lst (random (length lst))))

(define progA
  '((not a j)
    (not c t)
    (and d t)
    (or t j)
    (walk)))

;; @ A B C D E F G H I
;; ? ? ? ? ? ? ? ? ? ?
(define progB
  '((not c j) ;; no c, but d and h
    (and d j)
    (and h j)
    (not b t)
    (and d t)
    (or t j)
    (not a t) ;; not a/last resort?
    (or t j)
    (run)))

(define (make stmt)
  (match stmt
    ((x '<- ('not y))
     `(not ,x ,y))
    ((x '<- y)
     `((not ,x ,y)
       (not ,x ,x)))
    (else (display-ln stmt))))

(define atom?
  symbol?)

(define (pump- formula)
  (match formula
    ((? atom? x) `(- ,x))
    (('+ x y) `(* ,(pump- x) ,(pump- y)))
    (('* x y) `(+ ,(pump- x) ,(pump- y)))
    (('- x) x)))

(define (cnf formula)
  (match formula
    (('- x) (pump- (cnf x)))
    (('+ z ('* x y))
     `(* ,(cnf `(+ ,x ,z)) ,(cnf `(+ ,y ,z))))
    (('+ ('* x y) z)
     `(* ,(cnf `(+ ,x ,z)) ,(cnf `(+ ,y ,z))))
    (else formula)))


;; j <- (or c d) <-> (not (and (not c) (not d)))
;; =>
;; t <- (and (not c) (not d))
;; t <-
