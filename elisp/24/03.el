(with-temp-buffer
  (insert-file-contents "~/code/aoc/input/2024/3.in")
  (let ((mul (rx (or (seq "mul("
			  (group (+ digit))
			  ","
			  (group (+ digit))
			  ")")
		     "do()"
		     "don't()")))
	(a 0)
	(b 0)
	(add-to-b? t))
    (while (re-search-forward mul nil t)
      (let ((match (match-string 0)))
	(cond ((string-equal match "do()")
	       (setq add-to-b? t))
	      ((string-equal match "don't()")
	       (setq add-to-b? nil))
	      (t
	       (let ((x (string-to-number
			 (buffer-substring (match-beginning 1) (match-end 1))))
		     (y (string-to-number
			 (buffer-substring (match-beginning 2) (match-end 2)))))
		 (setq a (+ a (* x y)))
		 (when add-to-b?
		   (setq b (+ b (* x y)))))))))
    (gui-select-text (number-to-string b)) ;; woah
    (list a b)))
