(load "~/code/aoc/load.ss")
(advent-year 24) (advent-day 9)
(define input
  (map (lambda (c)
	 (fxmax 0 (char- c #\0)))
       (string->list "2333133121414131402\n")
;;       (parse-advent input-chars)
       ))

(define-record-type filesystem
  (fields files empty))

(define (new-filesystem)
  (make-filesystem t:empty t:empty))

(define (insert-file/space filesystem file size id marker)
  (let* ((file-map (filesystem-files filesystem))
	 (space-map (filesystem-empty filesystem))
	 (ixs (t:lookup-with-default size s:empty-set space-map)))
    (make-filesystem (t:insert id (cons marker file) file-map)
		     (t:insert size (s:insert (+ marker file) ixs) space-map))))

(define (initiate-filesystem spec)
  (let lp ((fs (new-filesystem)) (id 0) (marker 0) (spec spec))
    (match spec
      ((file size spec ...)
       (lp (insert-file/space fs file size id marker)
	   (1+ id)
	   (+ marker file size)
	   spec))
      ('() fs))))

(define (view-filesystem fs)
  (let lp ((spec (t:tree->alist (filesystem-files fs))) (mem '()))
    (match spec
      (((id-a . (ix-a . sz-a)) (id-b . (ix-b . sz-b)) spec ...)
       (lp (cons (cons id-b (cons ix-b sz-b)) spec)
	   (cons* (make-list (- ix-b ix-a sz-a) '*) ;; later: change to 0
		  (make-list sz-a id-a)
		  mem)))
      (((id . (ix . sz)))
       (fold-right append '() (reverse (cons (make-list sz id) mem)))))))

;; now, to move a given file by id to some empty space...
(define (relocate-file fs id)
  (define files (filesystem-files fs))
  (define space (filesystem-empty fs))
  (match (t:lookup id files)
    ((id ix . sz)
     (match (t:minimum (t:split>= sz space))
       ;; not quite right... need minimum index among all remaining trees...
       ;; so t:minimum is incorrect...
       ((available . ixs)
	(match (s:minimum ixs)
	  (new-ix
	   ;; remove ix
	   ;; add (- available sz) to empty map if > 0
	   ;; remove 
	   (cons available (s:minimum ixs)))
	  (#f fs)))
       (_ fs)) ;; no space available
     )))

(define (part-b)
;  (view-filesystem (initiate-filesystem input))
  (relocate-file (initiate-filesystem input) 9)
  )
