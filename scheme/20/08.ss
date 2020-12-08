(load "~/code/aoc/load.ss")
(advent-year 20) (advent-day 8)

(define code
  (list->vector (parse-advent lines)))

(define-record-type vm
  (fields acc pc mem history))

(define (run vm)
  (match vm
    (($ vm acc pc mem history)
     (if (or (= (vector-length mem) pc)
	     (s:member? pc history))
	 vm
	 (match (vector-ref mem pc)
	   (`(acc ,da) (run (make-vm (+ acc da)
				     (1+ pc)
				     mem
				     (s:insert pc history))))
	   (`(nop ,x)  (run (make-vm acc
				     (1+ pc)
				     mem
				     (s:insert pc history))))
	   (`(jmp ,dp) (run (make-vm acc
				     (+ pc dp)
				     mem
				     (s:insert pc history)))))))))

(define (new program)
  (make-vm 0 0 program s:empty-set))

(define (part-a program)
  (vm-acc (run (new program))))

(define (part-b program)
  (call/cc
   (lambda (exit)
     (do ((i 0 (1+ i)))
	 ((= i (vector-length program)))
       (match (vector-ref program i)
	 (`(nop ,dx)
	  (let ((p (vector-copy program)))
	    (vector-set! p i `(jmp ,dx))
	    (let ((vm (run (new p))))
	      (when (= (vector-length program) (vm-pc vm))
		(exit (vm-acc vm))))))
	 (`(jmp ,dx)
	  (let ((p (vector-copy program)))
	    (vector-set! p i `(nop ,dx))
	    (let ((vm (run (new p))))
	      (when (= (vector-length program) (vm-pc vm))
		(exit (vm-acc vm))))))
	 (_ #f))))))
