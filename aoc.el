;;; -*- lexical-binding: t; -*-
(require 'request)

(defvar aoc-cookie
  (with-temp-buffer
    (insert-file-contents "~/code/aoc/cookie")
    (buffer-string)))

(defun aoc-input-file (year day)
  (format "~/code/aoc/input/%s/%s.in" year day))

(defun aoc-download-input (year day)
  (let ((url (format "https://adventofcode.com/%d/day/%d/input"
                     year day)))
    (request url
      :type "GET"
;;; .... how to do this properly
      :headers `(("Cookie" . ,(format "session=%S" aoc-cookie)))
      :success (lambda (data)
                 data))))

(defmacro with-aoc-input (&rest body)
  (declare (indent 0))
  (let* ((path (split-string (buffer-file-name) "/"))
	 (year (string-to-number (nth 6 path)))
	 (day (string-to-number (substring (nth 7 path) 0 2))))
    `(with-temp-buffer
       (insert-file-contents (aoc-input-file ,(+ 2000 year) ,day))
       ,@body)))

(provide 'aoc-input-file)
