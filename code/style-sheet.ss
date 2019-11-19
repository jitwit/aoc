(define (colorize-haskell haskell-string)
  (let* ((tmp (format "/tmp/~a" (gensym->unique-string (gensym))))
         (hscolor (format "HsColour -css -partial < ~a" tmp)))
    (with-output-to-file tmp
      (lambda ()
        (display haskell-string)))
    (let* ((ports (process hscolor))
           (out (car ports))
           (in (cadr ports)))
      (let loop ((x (read-char out)) (result '()))
        (if (eof-object? x)
            (begin
              (close-input-port out)
              (close-output-port in)
              (delete-file tmp)
              `(*raw-html* ,(list->string (reverse result))))
            (loop (read-char out) (cons x result)))))))

(define style-sheet
  `((haskell-src . ,(lambda (tag src)
                      (colorize-haskell src)))
    (mono . ,(lambda (_ str)
               `(tt ,str)))
    (item . ,(lambda (_ . stmts)
               `(li ,@stmts)
               ))
    (enum . ,(lambda (_ . items)
               `(ul ,@items)))
    (nl . ,(lambda _ '(br)))
    (css . ,(lambda _
              '(link (@ (rel "stylesheet")
                        (type "text/css")
                        (href "css/style.css")))))
    (css-from . ,(lambda (_ n)
                   `(link (@ (rel "stylesheet")
                             (type "text/css")
                             (href ,(rel-link-from-depth n "css/style.css"))))))
    (js-script . ,(lambda (_ n script)
                    `(script (@ (src ,(rel-link-from-depth n script)))
                             "")))
    (section . ,(lambda (_ n title)
                  (case n
                    ((1) `(h1 ,title))
                    ((2) `(h2 ,title))
                    ((3) `(h3 ,title))
                    ((4) `(h4 ,title)))))
    (raw-script . ,(lambda (_ s)
                     `(script (*raw-html* ,s))))
    (link . ,(lambda (_ link href)
               `(a (@ (href ,href))
                   ,link)))
    (screen . ,(lambda (_ id w h)
                 `(canvas (@ (id "canvas")
                             (width ,(number->string w))
                             (height ,(number->string h))))))
    (scheme-eval *macro* . ,(lambda (_ expr)
                              `(p
                                (code ,(string-append
                                        "> "
                                        ;;; fixme, this blows
                                        (with-output-to-string
                                         (lambda () (show-expression expr)))))
                                (nl)
                                (code ,(with-output-to-string
                                        (lambda () (show-expression (eval expr))))))))
    (scheme-define *macro* . ,(lambda (_ expr)
                                `(p
                                  (code ,(with-output-to-string
                                          (lambda () (show-expression expr)))))))
    ;;; this also blows
    (mathml . ,(lambda (_ expr)
                 (scheme->mathml expr)))
    (footer . ,(lambda x
                 (let* ((now (current-date))
                        (build (format "updated: ~a/~a/~a"
                                       (date-day now)
                                       (date-month now)
                                       (date-year now))))
                   `(footer
                     ,build))))
    (*default* . ,(lambda x x))
    (*text* . ,(lambda (tag str) str))))

(define (rel-link-from-depth n href)
  (if (zero? n)
      href
      (apply string-append
             `(,@(intersperse "/" (make-list n ".."))
               "/"
               ,href))))


