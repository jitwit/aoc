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

(defmacro with-aoc-input (year day &rest body)
  (declare (indent 2))
  `(with-temp-buffer
     (insert-file-contents (aoc-input-file ,year ,day))
     ,@body))

(provide 'aoc-input-file)
