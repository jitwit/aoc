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
      (with-input-from-string (list->string (cleaner))
                              parser))))

(define comma-separated
  (input-chars-transform-parse
   (lambda (c)
     (match c
       (#\, #\space)
       (x x)))
   input))

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

(define (take-by predicate xs)
  (if (or (null? xs) (predicate (car xs)))
      '()
      (cons (car xs) (take-by predicate (cdr xs)))))

(define (drop-until keyword xs)
  (if (or (null? xs) (eq? keyword (car xs)))
      xs
      (drop-until keyword (cdr xs))))

(define (drop-by predicate xs)
  (if (or (null? xs) (predicate (car xs)))
      xs
      (drop-by predicate (cdr xs))))

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

(define (split-by predicate xs)
  (if (null? xs)
      xs
      (let ((x (car xs))
	    (x* (cdr xs)))
	(if (predicate x)
	    (cons (cons x (take-by predicate x*))
		  (split-by predicate (drop-by predicate x*)))
	    (cons (take-by predicate xs)
		  (split-by predicate (drop-by predicate xs)))))))

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
  (format "~~/code/aoc/input/20~a/~a.in" (advent-year) (advent-day)))

(define (fetch-advent)
  (let ((auj (current-date)))
    (cond ((or (< (advent-year) (mod (date-year auj) 100))
               ;; if it's december, and the requested day matches today
               ;; make sure we're before 10 pm before triggering req
               (and (= 12 (date-month auj))
                    (= (date-day auj) (advent-day))
                    (< (date-hour auj) 25)))
           ;; fetch.sh contains curl request from firefox dev
           ;; outils. cookie goes stale after 30 days
           (let ((year (mod (advent-year) 100))
                 (day (advent-day)))
             (format #t "Fetching day ~a year 20~a~%" day year)
             (system
              (format "sh ~~/code/aoc/code/fetch.sh ~a ~a" year day))))
          (else (format #t "wake me up when december begins~%")))))

(define (advent-ensure)
  (let ((advent (advent-file)))
    (unless (file-exists? advent)
      (format #t "downloading ~s...~%" advent)
      (fetch-advent))))

(define (run-advent-parser parser file)
  (if (file-exists? file)
      (with-input-from-file file parser)
      (error 'parse-advent "failed to retrieve advent input" file)))

(define parse-advent
  (case-lambda
    ((parser)
     (let ((advent (advent-file)))
       (advent-ensure)
       (run-advent-parser parser advent)))
    ((parser file)
     (run-advent-parser parser file))))

(define (solve-advent part-a part-b)
  ((with-foreground 'red)
   (lambda ()
     (format #t "part-a: ~a~%" (time (part-a)))
     ))
  ((with-foreground 'green)
   (lambda ()
     (format #t "part-b: ~a~%" (time (part-b))))))

;;;; Grid

;;; North East West South
(define (grid4 z)
  `(,(+ z 1) ,(- z 1) ,(+ z 0+i) ,(+ z 0-i)))

(define (nesw z)
  `(,(+ z 1) ,(- z 1) ,(+ z 0+i) ,(+ z 0-i)))

(define (grid8 z)
  `(,(+ z 1+i) ,(+ z 0+i) ,(+ z -1+i)
    ,(+ z -1) ,(+ z 1)
    ,(+ z 1-i) ,(+ z 0-i) ,(+ z -1-i)))

(define (complex x y)
  (+ x (* 0+i y)))

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

(define matrix-ref
  (case-lambda
    ((M i j) (vector-ref (vector-ref M i) j))
    ((M z) (vector-ref (vector-ref M (real-part z)) (imag-part z)))))

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

(define (swap x.y)
  (cons (cdr x.y) (car x.y)))

(define (boolean->number b)
  (if b 1 0))

(define (digit-at i n)
  (fxmod (fx/ n (expt 10 (fx1+ i))) 10))

(define (sign x)
  (cond
   ((< 0 x) 1)
   ((< x 0) -1)
   (else 0)))

(define (eq-hashtable-copy H)
  (define H* (make-eq-hashtable))
  (hash-table-for-each H
                       (lambda (x y)
                         (hashtable-set! H* x y)))
  H*)

(define (eqv-hashtable-copy H)
  (define H* (make-eqv-hashtable))
  (vector-for-each (lambda (x.y)
                     (match x.y
                       ((x . y)
                        (hashtable-set! H* x y))))
                   (hashtable-cells H))
  H*)

(define (Re/Im z)
  (values (real-part z) (imag-part z)))

(define (bounding-box-C zs) ;; assume zs nonempty
  (define-values (x-lo y-lo) (Re/Im (car zs)))
  (define x-hi x-lo)
  (define y-hi y-lo)
  (for-all (lambda (z)
             (define-values (z-re z-im) (Re/Im z))
             (set! x-lo (min x-lo z-re))
             (set! x-hi (max x-hi z-re))
             (set! y-lo (min y-lo z-im))
             (set! y-hi (max y-hi z-im)))
           (cdr zs))
  (values x-lo x-hi y-lo y-hi))

(define (string-split s seps)
  (string-tokenize s (char-set-complement
		      (apply char-set (string->list seps)))))

(define-syntax defmemo
  (syntax-rules (: string eqv) ;; why don't these work when defmemo in library?
    ((_ (f x) body ...)
     (define f
       (let ((mem (make-hash-table))
             (g (lambda (x) body ...)))
         (lambda (y)
           (let ((f-y (hashtable-ref mem y #f)))
             (or f-y
                 (let ((f-y (g y)))
                   (hashtable-set! mem y f-y)
                   f-y)))))))
    ((_ (f x : eqv) body ...)
     (define f
       (let ((mem (make-eqv-hashtable))
             (g (lambda (x) body ...)))
         (lambda (y)
           (let ((f-y (hashtable-ref mem y #f)))
             (or f-y
                 (let ((f-y (g y)))
                   (hashtable-set! mem y f-y)
                   f-y)))))))
    ((_ (f x : string) body ...)
     (define f
       (let ((mem (make-hashtable string-hash string=?))
             (g (lambda (x) body ...)))
         (lambda (y)
           (let ((f-y (hashtable-ref mem y #f)))
             (or f-y
                 (let ((f-y (g y)))
                   (hashtable-set! mem y f-y)
                   f-y)))))))
    ((_ (f x : hash eq) body ...)
     (define f
       (let ((mem (make-hashtable hash eq))
             (g (lambda (x) body ...)))
         (lambda (y)
           (let ((f-y (hashtable-ref mem y #f)))
             (or f-y
                 (let ((f-y (g y)))
                   (hashtable-set! mem y f-y)
                   f-y)))))))
    ((_ (f x y ...) body ...)
     (define f
       (let ((mem (make-hashtable equal-hash equal?))
             (g (lambda (x y ...) body ...)))
         (lambda xy
	   (if (hashtable-contains? mem xy)
	       (hashtable-ref mem xy 'ohno)
               (let ((f-xy (apply g xy)))
                 (hashtable-set! mem xy f-xy)
                 f-xy))))))))
