(load "~/code/advent/load.ss")

(advent-day 25)
(advent-year 19)

(define program
  (parse-advent comma-separated))

(define engine (intcode program))

(define (get-msg m)
  (list->string (map integer->char (read-output m))))

(define (put-cmd m cmd)
  (send-input* m `(,@(map char->integer (string->list cmd)) 10)))

(define bad-items
  '("infinite loop" "escape pod" "molten lava" "photons" "giant electromagnet"))

(define (cmd->string symbols)
  (apply string-append (intersperse " " (map symbol->string symbols))))

(define (random-element lst)
  (list-ref lst (random (length lst))))

(define (parse-objects type prompt message)
  (let ((lines (member prompt (with-input-from-string message lines-raw))))
    (if (not lines)
        (list type)
        (let loop ((lines (cdr lines)) (items '()))
          (match lines
            (("" _ ...)
             (cons type (reverse items)))
            ((item lines ...)
             (loop lines (cons (substring item 2 (string-length item)) items))))))))

(define (parse-doors message)
  (parse-objects 'door "Doors here lead:" message))

(define (parse-items message)
  (parse-objects 'items "Items here:" message))

(define (parse-inventory message)
  (parse-objects 'inventory "Items in your inventory:" message))

(define (parse-win message)
  (with-input-from-string (car (string-tokenize message char-set:digit)) read))

(define (parse-state message)
  (list (parse-doors message)
        (parse-items message)))

(define (move-randomly engine message)
  (let ((doors (cdr (parse-doors message))))
    (if (null? doors) ;; shouldn't happen but does? idk, had too much to drink
        (put-cmd engine (random-element '("north" "east" "west" "south")))
        (put-cmd engine (random-element doors)))))

(define (pickup-items engine message)
  (cond ((parse-items message) =>
         (lambda (items)
           (for-all (lambda (item)
                      (put-cmd engine (string-append "take " item))
                      (run-until-halt engine))
                    (lset-difference string=? (cdr items) bad-items))))))

(define (pickup-specific-items engine target-items message)
  (cond ((parse-items message) =>
         (lambda (items)
           (for-all (lambda (item)
                      (put-cmd engine (string-append "take " item)))
                    (lset-intersection string=? (cdr items) target-items))))))

(define (explore-mode engine message)
  (pickup-items engine message)
  (move-randomly engine message))

(define (drink-mode engine items message)
  (pickup-specific-items engine items message)
  (move-randomly engine message))

(define (explore! engine iters)
  (reset! engine)
  (do ((i 0 (1+ i)))
      ((or (done? engine) (= i iters)))
    (unless (done? engine)
      (run-until-halt engine)
      (explore-mode engine (get-msg engine)))))

(define (drink! engine items iters)
  (reset! engine)
  (do ((i 0 (1+ i)))
      ((or (done? engine) (= i iters)))
    (unless (done? engine)
      (drink-mode engine items (get-msg engine))
      (run-until-halt engine))))

(define (find-available-items engine iters)
  (explore! engine iters)
  (put-cmd engine "inv")
  (run-until-halt engine)
  (cdr (parse-inventory (get-msg engine))))

(define (drunken-engine engine items iters size)
  (display-ln (list "ITEMS:" (map list items))) (newline)
  (call/cc
   (lambda (win)
     (for-all (lambda (combo)
                (display-ln (list "trying:" (map list combo)))
                (drink! engine combo iters)
                (when (done? engine)
                  (win (cons (parse-win (get-msg engine)) combo))))
              (combinations items size))
     (newline) (display-ln (list "FAIL!" size)) (newline)
     (drunken-engine engine items iters (1+ size)))))

(define (drunken-walk engine iters)
  (let ((items (find-available-items engine iters)))
    (drunken-engine engine items iters 4)))

(define (solve)
  (drunken-walk (intcode program) 666))
