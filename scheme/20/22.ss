(optimize-level 3)
(load "~/code/aoc/load.ss")
(advent-year 20) (advent-day 22)

(define *input*
  (parse-advent input))

(define player-1
  (take-while (compose not (curry eq? 'Player)) (list-tail *input* 2)))

(define player-2
  (list-tail (drop-while (compose not (curry eq? 'Player)) (list-tail *input* 2)) 2))

(define (score cards)
  (fold-left + 0
	     (map *
		  cards
		  (reverse (cdr (iota (1+ (length cards))))))))

(define (winner result)
  (car result))

(define (combat p1 p2)
  (cond ((null? p1) `(player-2 ,(score p2)))
	((null? p2) `(player-1 ,(score p1)))
	(else
	 (let ((a (car p1)) (b (car p2)) (p1 (cdr p1)) (p2 (cdr p2)))
	   (if (< a b)
	       (combat p1 `(,@p2 ,b ,a))
	       (combat `(,@p1 ,a ,b) p2))))))

(define (recursive-combat p1 p2)
  (define history
    (make-hashtable (lambda (state)
		      (equal-hash (list-head state 2)))
		    equal?))
  (let lp ((p1 p1) (p2 p2) (n (length p1)) (m (length p2)))
    (cond
     ((null? p1) `(player-2 ,(score p2)))
     ((null? p2) `(player-1 ,(score p1)))
     (else
      (let ((a (car p1)) (b (car p2)) (p1 (cdr p1)) (p2 (cdr p2)))
	(let* ((state `(,a ,b ,p1 ,p2))
	       (previously? (hashtable-contains? history state)))
	  (hashtable-set! history state #t)	  
	  (cond
	   (previously? `(player-1 ,(score (cons a p1))))
	   ((and (< a n) (< b m))
	    (let* ((q1 (list-head p1 a)) (m1 (fold-left max 0 q1))
		   (q2 (list-head p2 b)) (m2 (fold-left max 0 q2)))
	      (cond ; if player 1 has trump card so to speak
	       ((and (> m1 m2) (>= m1 (+ a b)))
		(lp `(,@p1 ,a ,b) p2 (1+ n) (1- m)))
	       ((eq? 'player-1 (winner (recursive-combat q1 q2)))
		(lp `(,@p1 ,a ,b) p2 (1+ n) (1- m)))
	       (else
		(lp p1 `(,@p2 ,b ,a) (1- n) (1+ m))))))
	   (else
	    (if (< a b)
		(lp p1 `(,@p2 ,b ,a) (1- n) (1+ m))
		(lp `(,@p1 ,a ,b) p2 (1+ n) (1- m)))))))))))
