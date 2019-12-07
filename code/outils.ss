(define (render-html post)
  (pre-post-order post style-sheet))

(define (render-page page file)
  (when (file-exists? file)
    (delete-file file))
  (with-output-to-file file
    (lambda ()
      (put-html
       (render-html page)))))

(define (quick-render page)
  (let ((tmp "tmp.html"))
    (render-page page tmp)
    (system (string-append "open " tmp))
    (delete-file tmp)))

(define (intersperse sep xs)
  (let ((xs (fold-right (lambda (x y)
                          (cons* sep x y))
                        '()
                        xs)))
    (if (or (null? xs) (null? (cdr xs)))
        '()
        (cdr xs))))

;;;; Colorize terminal outputs
(define foreground-color-table
  '((default . 39)
    (black . 30)
    (red . 31)
    (green . 32)
    (yellow . 33)
    (blue . 34)
    (magenta . 35)
    (cyan . 36)
    (light-gray . 37)
    (dark-gray . 90)
    (light-red . 91)
    (light-green . 92)
    (light-yellow . 93)
    (light-blue . 94)
    (light-magenta . 95)
    (light-cyan . 96)
    (white . 97)))

(define (foreground-color-escape color)
  (cond ((assq color foreground-color-table) => cdr)
        (else 39)))

(define (put-term-code code)
  (display "\033[") (display code) (display "m"))

(define (clear-term-code)
  (display "\033[0m"))

(define (with-foreground color)
  (let ((escape (foreground-color-escape color)))
    (lambda (thunk)
      (put-term-code escape)
      (thunk)
      (clear-term-code))))

(define (display-with-foreground color object)
  (let ((escape (foreground-color-escape color)))
    (put-term-code escape)
    (display object)
    (clear-term-code)))

(define (digit-at i n)
  (mod (quotient n (expt 10 (1+ i))) 10))

