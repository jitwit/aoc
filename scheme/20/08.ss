(optimize-level 3)
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

(define (swap program j)
  (match (vector-ref program j)
    (`(nop ,dx) (vector-set! program j `(jmp ,dx)))
    (`(jmp ,dx) (vector-set! program j `(nop ,dx)))
    (_          (void))))

(define (part-a program)
  (vm-acc (run (new program))))

(define (part-b program)
  (let loop ((j 0))
    (swap program j)
    (let ((vm (run (new program))))
      (swap program j)
      (if (= (vector-length program) (vm-pc vm))
	  (vm-acc vm)
	  (loop (1+ j))))))
