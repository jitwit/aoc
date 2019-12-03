(load "~/code/advent/load.ss")
(advent-year 19)
(advent-day 3)

(define (gets sec)
  (let* ((s (symbol->string sec))
         (dir (string-ref s 0))
         (am (substring s 1 (string-length s))))
    (cons dir (string->number am))))

(define sects
  (map (lambda (line)
         (map gets (with-input-from-string line comma-separated)))
       (parse-advent lines-raw)))

(define (mag z)
  (+ (abs (real-part z))
     (abs (imag-part z))))

(define (step sec pos)
  (let ((m (cdr sec)))
    (match (car sec)
      (#\R (+ pos m))
      (#\L (- pos m))
      (#\U (+ pos (* m 0+i)))
      (#\D (- pos (* m 0+i))))))

(define (trip sects)
  (let loop ((xs '())
             (loc 0)
             (ys sects))
    (if (null? ys)
        (reverse (cons loc xs))
        (let ((loc* (step (car ys) loc )))
          (loop (cons loc xs)
                loc*
                (cdr ys))))))

(define (manh z)
  (+ (abs (real-part z))
     (abs (imag-part z))))

(define tripa
  (trip (car sects)))

(define tripb
  (trip (cadr sects)))

(define intersections
  '())

(define solve-a
  (lambda (is)
    (apply min (filter (lambda (x) (not (zero? x)))
                       (map (lambda (i) (apply + (map abs i))) is)))))

(define solve-b
  (lambda (is)
    (sort (lambda (x y)
            (< (car x) (car y)))
          is)))

(define (travel)
  (define s 0)
  (set! intersections '())
  (let xloop ((xs tripa) (tx 0))
    (if (null? (cdr xs))
        (solve-b intersections)
        (let ((a (car xs))
              (b (cadr xs)))
          (let yloop ((ys tripb) (ty 0))
            (if (null? (cdr ys))
                (xloop (cdr xs) (+ tx (mag (- b a))))
                (let ((c (car ys))
                      (d (cadr ys)))
                  (let ((ra (real-part a))
                        (rb (real-part b))
                        (rc (real-part c))
                        (rd (real-part d))
                        (ia (imag-part a))
                        (ib (imag-part b))
                        (ic (imag-part c))
                        (id (imag-part d)))
                    (cond ((and (= ra rb)
                                (= ic id)
                                (<= (min rc rd) ra (max rc rd))
                                (<= (min ia ib) ic (max ia ib)))
                           (push! (list (+ tx (abs (- ic ia))
                                           ty (abs (- ra rc)))
                                        ra ic) intersections))
                          ((and (= ia ib)
                                (= rc rd)
                                (<= (min ic id) ia (max ic id))
                                (<= (min ra rb) rc (max ra rb)))
                           (push! (list (+ tx (abs (- ic ia))
                                           ty (abs (- ra rc)))
                                        rc ia) intersections)))
                    (yloop (cdr ys)
                           (+ ty (mag (- d c))))))))))))
