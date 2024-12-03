(with-temp-buffer
  (insert-file-contents "~/code/aoc/input/2024/3.in")
  (let ((mul (rx (seq "mul("
		      (group (+ digit))
		      ","
		      (group (+ digit))
		      ")")))
	(a 0))
    (while (re-search-forward mul nil t)
      (setq a
	    (+ a
	       (* (string-to-number
		   (buffer-substring (match-beginning 1) (match-end 1)))
		  (string-to-number
		   (buffer-substring (match-beginning 2) (match-end 2)))))))
    (gui-select-text (number-to-string a)) ;; woah
    a))
