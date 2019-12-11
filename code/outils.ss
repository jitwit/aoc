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
  (fxmod (fx/ n (expt 10 (fx1+ i))) 10))

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
