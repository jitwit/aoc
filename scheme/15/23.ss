(include "~/code/aoc/load.ss")
(advent-year 15)
(advent-day 23)

(define input-program
  (with-input-from-string
      (list->string
       (remv #\, (parse-advent input-chars)))
    lines))

(define-record-type machine
  (fields program pc a b))

(define (step m)
  (match m
    (($ machine code pc r-a r-b)
     (match (list-ref code pc)
       (('hlf 'a) (make-machine code (1+ pc) (/ r-a 2) r-b))
       (('hlf 'b) (make-machine code (1+ pc) r-a (/ r-b 2)))
       (('tpl 'a) (make-machine code (1+ pc) (* r-a 3) r-b))
       (('tpl 'b) (make-machine code (1+ pc) r-a (* r-b 3)))
       (('inc 'a) (make-machine code (1+ pc) (1+ r-a) r-b))
       (('inc 'b) (make-machine code (1+ pc) r-a (1+ r-b)))
       (('jmp dx) (make-machine code (+ pc dx) r-a r-b))
       (('jie r dx)
	(cond ((and (eq? r 'a) (even? r-a))
	       (make-machine code (+ pc dx) r-a r-b))
	      ((and (eq? r 'b) (even? r-b))
	       (make-machine code (+ pc dx) r-a r-b))
	      (else (make-machine code (1+ pc) r-a r-b))))
       (('jio r dx)
	(cond ((and (eq? r 'a) (= r-a 1))
	       (make-machine code (+ pc dx) r-a r-b))
	      ((and (eq? r 'b) (= r-b 1))
	       (make-machine code (+ pc dx) r-a r-b))
	      (else (make-machine code (1+ pc) r-a r-b))))))))

(define (execute m)
  (call/cc
   (lambda (k)
     (with-exception-handler
	 (lambda (e)
	   (k (machine-b m)))
       (lambda ()
	 (let lp ()
	   (set! m (step m))
	   (lp)))))))

(define (part-a)
  (execute (make-machine input-program 0 0 0)))

(define (part-b)
  (execute (make-machine input-program 0 1 0)))
