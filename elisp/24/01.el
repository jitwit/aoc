;; cursed emacs solution that uses https://github.com/jitwit/jpl-mode
;; to do the computations.
(with-aoc-input
  (let ((input (mapcar #'string-to-number (split-string (buffer-string)))))
    (emacs->J WWJ "in" input)
    (let ((a (J-run "+/|-//:~\"1 in=:|:_2]\\ in"))
	  (b (J-run "([:+/[*[:+/=/~)/ in")))
      (gui-select-text (number-to-string b))
      (list a b))))
