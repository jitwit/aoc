(define (input)
  (let loop ((next (read))
	     (tokens '()))
    (if (eof-object? next)
	(reverse tokens)
	(loop (read) (cons next tokens)))))

(define (lines)
  (let ((port (current-input-port)))
    (let loop ((line (get-line port))
	       (ls '()))
      (if (eof-object? line)
	  (reverse ls)
	  (loop (get-line port)
		(cons (with-input-from-string line input)
		      ls))))))

(define (lines-raw)
  (let ((port (current-input-port)))
    (let loop ((line (get-line port))
	       (ls '()))
      (if (eof-object? line)
	  (reverse ls)
	  (loop (get-line port)
		(cons line ls))))))

(define (input-chars)
  (let loop ((next (read-char))
	     (chars '()))
    (if (eof-object? next)
	(reverse chars)
	(loop (read-char) (cons next chars)))))

(define (input-chars-with transform)
  (lambda ()
    (let loop ((next (read-char))
	       (chars '()))
      (if (eof-object? next)
	  (reverse chars)
	  (loop (read-char) (cons (transform next) chars))))))

(define (input-chars-transform-parse transform parser)
  (lambda ()
    (let ((cleaner (input-chars-with transform)))
      (with-input-from-string (list->string
				cleaner)
			      parser))))

(define (n-tuples n xs)
  (let loop ((xs xs) (vs '()))
    (if (null? xs)
	(reverse vs)
	(loop (list-tail xs n)
	      (cons (list-head xs n)
		    vs)))))

(define (take-until keyword xs)
  (if (or (null? xs) (eq? keyword (car xs)))
      '()
      (cons (car xs) (take-until keyword (cdr xs)))))

(define (drop-until keyword xs)
  (if (or (null? xs) (eq? keyword (car xs)))
      xs
      (drop-until keyword (cdr xs))))

(define (split-on keyword xs)
  (if (null? xs)
      xs
      (let ((x (car xs))
	    (x* (cdr xs)))
	(if (eq? x keyword)
	    (cons (cons x (take-until keyword x*))
		  (split-on keyword (drop-until keyword x*)))
	    (cons (take-until keyword xs)
		  (split-on keyword (drop-until keyword xs)))))))

(define (intersperse x xs)
  (let ((xss (fold-right (lambda (y ys)
			   (cons* x y ys))
			 '()
			 xs)))
    (or (and (null? xss) '())
	(cdr xss))))

(define port-fold
  (lambda (reader f x0)
    (let fold ((x (reader)) (acc x0))
      (if (eof-object? x)
	  acc
	  (fold (reader) (f acc x))))))

;;; ADVENT
(define advent-year
  (make-parameter
    (mod (date-year (current-date))
	 100)))

(define advent-day
  (make-parameter
   (date-day (current-date))))

(define (advent-file)
  (format "~~/code/advent/input/~a/~a.in" (advent-year) (advent-day)))

(define (fetch-advent)
  (let ((auj (current-date)))
    (cond ((or (< (advent-year) (mod (date-year auj) 100))
               ;; if it's december, and the requested day matches today
               ;; make sure we're before 10 pm before triggering req
               (and (= 12 (date-month auj))
                    (= (date-day auj) (advent-day))
                    (< (date-hour auj) 22)))
           ;; fetch.sh contains curl request from firefox dev
           ;; outils. cookie goes stale after 30 days
           (let ((year (advent-year))
                 (day (advent-day)))
             (format #t "Fetching day ~a year 20~a~%" day year)
             (system
              (format "sh ~~/code/advent/code/fetch.sh ~a ~a" year day))))
          (else (format #t "wake me up when december begins~%")))))

(define (advent-ensure)
  (let ((advent (advent-file)))
    (unless (file-exists? advent)
      (format #t "downloading ~s...~%" advent)
      (fetch-advent))))

(define (parse-advent parser)
  (let ((advent (advent-file)))
    (advent-ensure)
    (if (file-exists? advent)
	(with-input-from-file advent parser)
	(error 'parse-advent "failed to retrieve advent input"
               advent (advent-year) (advent-day)))))

(define (solve-advent part-a part-b parsed-input)
  (format #t "part-a: ~a~%part-b: ~a~%"
	  (part-a parsed-input)
	  (part-b parsed-input)))

;;;; Grid
(define (grid-adjacent i j)
  (let ((j-1 (1- j))
	(j+1 (1+ j))
	(i-1 (1- i))
	(i+1 (1+ i)))
    `((,i-1 ,j-1)
      (,i-1 ,j)
      (,i-1 ,j+1)
      (,i ,j-1)
      (,i ,j+1)
      (,i+1 ,j-1)
      (,i+1 ,j)
      (,i+1 ,j+1))))

;;; North East West South
(define (news i j)
  `((,(1- i) ,j)
    (,i ,(1- j))
    (,i ,(1+ j))
    (,(1+ i) ,j)))

(define (matrix m n)
  (let ((v (make-vector m)))
    (do ((i 0 (fx1+ i)))
        ((fx= i m) v)
      (vector-set! v i (make-vector n)))))

(define (matrix-rows M)
  (vector-length M))

(define (matrix-cols M)
  (vector-length (vector-ref M 0)))

(define (matrix-dimension M)
  (values (matrix-rows M) (matrix-cols M)))

(define (matrix-ref M i j)
  (vector-ref (vector-ref M i) j))

(define (matrix-set! M i j x)
  (vector-set! (vector-ref M i) j x))

(define (matrix-tabulate! M g)
  (let-values (((r c) (matrix-dimension M)))
    (do ((i 0 (fx1+ i)))
        ((fx= i r))
      (let ((row (vector-ref M i)))
        (do ((j 0 (fx1+ j)))
            ((fx= j c))
          (vector-set! row j (g i j (vector-ref row j))))))))

(define (matrix-tabulate M g)
  (let-values (((r c) (matrix-dimension M)))
    (let ((N (matrix r c)))
      (do ((i 0 (fx1+ i)))
          ((fx= i r) N)
        (let ((row-M (vector-ref M i))
              (row-N (vector-ref N i)))
          (do ((j 0 (fx1+ j)))
              ((fx= j c))
            (vector-set! row-N j (g i j (vector-ref row-M j)))))))))

(define (matrix-transpose M)
  (let ((N (call-with-values (lambda () (matrix-dimension M))
             (lambda (r c)
               (matrix c r)))))
    (matrix-tabulate! N (lambda (i j _)
                          (matrix-ref M j i)))
    N))

(define (matrix-row M i)
  (vector-ref M i))

(define (matrix-column M j)
  (vector-map (lambda (row)
                (vector-ref row j))
              M))

(define (matrix-modify! M i j f)
  (let ((row (vector-ref M i)))
    (vector-set! row j (f (vector-ref row j)))))

(define (vector-fold-right f x V)
  (let loop ((i (fx1- (vector-length V))) (x x))
    (if (fx< i 0) x (loop (fx1- i) (f (vector-ref V i) x)))))

(define (vector-sum V)
  (vector-fold-right + 0 V))
