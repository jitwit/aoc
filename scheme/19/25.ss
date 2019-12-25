(load "~/code/advent/load.ss")

(define program (parse-advent comma-separated))

(define engine (cpu program))

(define (put-msg m)
  (list->string (map integer->char (read-output m))))

(define (put-cmd m cmd)
  (send-input* m `(,@(map char->integer (string->list cmd)) 10)))

(define (dump! m)
  (list->string
   (map integer->char
        (filter (lambda (x) (<= 10 x 128))
                (vector->list
                 (dump-cache1 m))))))

(define bad-items
  '((infinite loop) (escape pod) (molten lava) (photons) (giant electromagnet)))

(define items
  '((ornament) (cake) (easter egg) (hypercube) (hologram) (fuel cell) (dark matter) (klein bottle)))

(define (test-items)
  (random-element (combinations items 4)))

(define (cmd->string symbols)
  (apply string-append (intersperse " " (map symbol->string symbols))))

(define (random-element lst)
  (list-ref lst (random (length lst))))

(define (pickup! m items)
  (for-all (lambda (item)
             (put-cmd m (cmd->string (append '(take) item))))
           items))

(define (move! m)
  (put-cmd m (cmd->string (random-element '((north) (east) (west) (south))))))

(define (crawl n items)
  (let loop ((n n))
    (unless (or (done? engine) (zero? n))
      (run-until-halt engine)
      ;;       (read-output engine)
      (pickup! engine items)
      (run-until-halt engine)
      (move! engine)
      (run-until-halt engine)
      (loop (1- n)))))

(define (crawl! n k)
  (define quit? #f)
  (do ((its (combinations items k) (cdr its)))
      ((or (done? engine) (null? its)))
    (display-ln (list (length its) (car its)))
    (reset! engine)
    (time
     (crawl n (car its)))))

(define winning-items
  '((easter egg) (hologram) (dark matter) (klein bottle)))

(define (abbrev cmd)
  (case cmd
    ((n) 'north)
    ((e) 'east)
    ((w) 'west)
    ((s) 'south)
    ((q) 'quit)
    ((i) 'inv)
    (else cmd)))

(define (read-cmd)
  (let loop ((xs '()) (x (read)))
    (if (or (eof-object? x) (eq? x 'g))
        (cmd->string (map abbrev (reverse xs)))
        (loop (cons x xs) (read)))))

(define history '())
(define histories '())

(define (save-history)
  (push! history histories))

(define (game)
  (let loop ()
    (unless (done? engine)
      (run-until-halt engine)
      (display-ln (put-msg engine))
      (let ((cmd (read-cmd)))
        (push! cmd history)
        (unless (string=? cmd "quit")
          (put-cmd engine cmd)
          (loop))))))

