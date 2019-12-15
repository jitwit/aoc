(load "~/code/advent/load.ss")

(define rules
  (parameterize ((advent-year 19) (advent-day 14))
    (map (lambda (rule)
           (match (string-tokenize rule (char-set-complement (char-set #\= #\>)))
             ((in out)
              (cons (with-input-from-string out comma-separated)
                    (n-tuples 2 (with-input-from-string in comma-separated))))))
         (parse-advent lines-raw))))

(define chemical-table
  (let ((table (make-hash-table)))
    (for-all (lambda (rule)
               (match rule
                 (((n x) xs ...)
                  (hashtable-set! table x (cons n xs)))))
             rules)
    table))

(define (lookup-recipe chemical)
  (hashtable-ref chemical-table chemical #f))

(define (chemical-ingredients chemical)
  (cond ((lookup-recipe chemical)
         => (lambda (entry)
              (map cadr (cdr entry))))
        (else '())))

(define (update-requirements chemical requirements)
  (match (lookup-recipe chemical)
    ((produces . ingredients)
     (let ((times (quotient (+ -1 produces (hashtable-ref requirements chemical 0))
                            produces)))
       (for-all (lambda (ingredient)
                  (match ingredient
                    ((amount chemical)
                     (hashtable-update! requirements
                                        chemical
                                        (lambda (needed)
                                          (+ needed (* times amount)))
                                        0))))
                ingredients)))
    (else (void))))

(define (produce chemicals fuel)
  (define requirements (make-hash-table))
  (hashtable-set! requirements 'FUEL fuel)
  (let loop ()
    (unless (null? chemicals)
      (update-requirements (pop! chemicals) requirements)
      (loop)))
  (hashtable-ref requirements 'ORE #f))

(define (partA)
  (let ((chemicals (topological-sort 'FUEL chemical-ingredients)))
    (produce chemicals 1)))

(define (partB)
  (let ((chemicals (topological-sort 'FUEL chemical-ingredients)))
    (let bin ((lo 1) (hi (inexact->exact 1e12)))
      (if (< hi lo) hi
          (let ((fuel (ash (+ lo hi) -1)))
            (let ((ore (produce chemicals fuel)))
              (if (<= ore 1e12)
                  (bin (1+ fuel) hi)
                  (bin lo (1- fuel)))))))))
