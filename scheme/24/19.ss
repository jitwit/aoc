(load "~/code/aoc/load.ss")
(advent-year 24) (advent-day 19)
(define patterns) (define designs)
(define (init)
  (match (parse-advent lines-raw ;; "small.in"
		       )
    ((ps "" ds ...)
     (set! patterns (string-split ps ", "))
     (set! designs ds))))

(define-syntax defmemo
  (syntax-rules ()
    ((_ (f x) body ...)
     (define f
       (let ((mem (make-hashtable string-hash string=?))
             (g (lambda (x) body ...)))
         (lambda (y)
           (let ((f-y (hashtable-ref mem y #f)))
             (or f-y
                 (let ((f-y (g y)))
                   (hashtable-set! mem y f-y)
                   f-y)))))))))

(defmemo (F design)
  (if (string-null? design)
      1
      (fold-right (lambda (pat n)
		    (+ n
		       (if (string-prefix? pat design)
			   (F (substring design
					 (string-length pat)
					 (string-length design)))
			   0)))
		  0
		  patterns)))

(define (part-a)
  (count (compose (curry < 0) F) designs))

(define (part-b)
  (apply + (map F designs)))

(define (main)
  (init)
  (solve-advent part-a part-b))
