;; cursed emacs solution that uses https://github.com/jitwit/jpl-mode
;; to do the computations.
(with-aoc-input
  (let ((input (mapcar #'string-to-number (split-string (buffer-string)))))
    (emacs->J WWJ "in" input)
    (let ((a (J-set&get "+/ | -/ /:~ \"1 in =: |: _2 ]\\ in"))
	  (b (J-set&get "([:+/[*[:+/=/~)/ in")))
      (gui-select-text (number-to-string b))
      (list a b))))
