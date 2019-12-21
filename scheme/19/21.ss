(load "~/code/advent/load.ss")

(define intcode
  (parameterize ((advent-day 21) (advent-year 19))
    (parse-advent comma-separated)))

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

(define (stmt->string stmt)
  (let ((pieces (intersperse " " (map symbol->string stmt))))
    (string-upcase (string-append (apply string-append pieces) "\n"))))

(define (stmts->string program)
  (apply string-append (map stmt->string program)))

(define progA
  '((not a j)
    (not c t)
    (and d t)
    (or t j)
    (walk)))

;; @ A B C D E F G H I
;; ? ? ? ? ? ? ? ? ? ?
(define progB
  '((not c j) ;; no c, but (d and) h
    (and h j)
    (not b t) ;; no b(, but d)
    (or t j)
    (not a t) ;; not a, have to jump now
    (or t j)
    (and d j) ;; need d no matter what
    (run)))
