(load "~/code/advent/code/biblio.ss")
(import (alga)
        (srfi :13)
        (only (euler) curry compose s:take)
        (matchable)
        (prefix (patricia) t:))
(advent-year 18)
(advent-day 7)
(print-gensym #f)

(define instructions
  (map (lambda (ab)
         (match (apply append (map string->list ab))
           ((a b) (cons (char->integer a)
                        (char->integer b)))))
       (n-tuples 2 (filter (compose (curry = 1) string-length)
                           (string-tokenize
                            (list->string
                             (parse-advent input-chars)))))))

(define (partA)
  (list->string
   (map integer->char
        (cdr
         (topological-sort
          (edges instructions))))))

(define-record-type workshop
  (fields time schedule))

(define (add-job job workshop)
  (match workshop
    (($ workshop t s)
     (make-workshop t (t:insert (+ t (time-required job)) job s)))))

(define (complete-job workshop)
  (match workshop
    (($ workshop t s)
     (if (t:empty? s)
         (values 'done (make-workshop t s))
         (let ((t* (t:minimum s)))
           (values (cdr t*)
                   (make-workshop (car t*) (t:delete (car t*) s))))))))

(define graph
  (edges instructions))

(define (workable-tasks shop tasks)
  (let ((schedule (t:tree->items (workshop-schedule shop))))
    (filter (lambda (task)
              (and (null? (incoming-edges task tasks))
                   (not (memv task schedule))))
            (vertex-list tasks))))

(define (time-required letter)
  (- letter 4))

(define (free-workers n shop)
  (- n (t:tree-size (workshop-schedule shop))))

(define (multi w instructions)
  (let work ((shop (make-workshop 0 t:empty))
             (tasks (edges instructions)))
    (if (t:empty? tasks)
        (workshop-time shop)
        (let* ((n (free-workers w shop))
               (ts (s:take n (workable-tasks shop tasks))))
          (if (or (zero? n) (null? ts))
              (let-values (((item shop) (complete-job shop)))
                (work shop (induce (lambda (task)
                                     (not (eqv? task item)))
                                   tasks)))
              (work (fold-right add-job shop ts) tasks))))))

(define (partB)
  (multi 5 instructions))
