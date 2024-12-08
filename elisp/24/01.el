;; cursed emacs solution that uses https://github.com/jitwit/jpl-mode
;; to do the computations.
(with-aoc-input
  (let ((input (mapcar #'string-to-number (split-string (buffer-string)))))
    (emacs->J WWJ "in" input) ; send input to J
    (let ((a (J-run "+/|-//:~\"1 in=:|:_2]\\ in")) ; calculate part a with J
	  (b (J-run "([:+/[*[:+/=/~)/ in")))       ; calculate part b with J
      (gui-select-text (number-to-string b))       ; grab to system clipboard
      (list a b))))
