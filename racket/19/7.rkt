#lang racket

(require "intcode.rkt")

(define program
  (with-input-from-file "../../input/19/7.in" parse-intcode))

(define (feed M N)
  (lambda ()
    (let run ()
      (case (step M)
        ((out) (send-input N (peek-output M)) (run))
        ((blocked) 'blocked)
        ((done) 'done)
        (else (run))))))

(define-syntax pop!
  (lambda (x)
    (syntax-case x ()
      ((_ xs)
       #'(let ((x (car xs)))
	   (set! xs (cdr xs))
	   x)))))

(define-syntax define-network
  (lambda (x)
    (syntax-case x (=> <- >?)
      ((_ (A ...) ((x => y) ...) ((m <- phase) ...) (>? T) program)
       #'(let* ((A (intcode program)) ...
		(feeds (list (feed x y) ...)))
	   (send-input m phase) ...
	   (let run ()
	     (if (done? T)
		 (peek-output T)
		 (let ((feed (pop! feeds)))
		   (unless (eq? 'done (feed))
		     (set! feeds `(,@feeds ,feed)))
		   (run)))))))))

(define (day7 phase-settings program)
  (let-values (((p h a s e) (apply values phase-settings)))
    (define-network (A B C D E)
      ((A => B) (B => C) (C => D) (D => E) (E => A))
      ((A <- p) (B <- h) (C <- a) (D <- s) (E <- e) (A <- 0))
      (>? E)
      program)))

(define (best-configuration phases)
  (foldr max 0 (map (lambda (phase-settings)
                      (day7 phase-settings program))
                    (permutations phases))))

(define (partA)
  (best-configuration '(0 1 2 3 4)))

(define (partB)
  (best-configuration '(5 6 7 8 9)))
