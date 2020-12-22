(optimize-level 3)
(load "~/code/aoc/load.ss")
(advent-year 20) (advent-day 22)

(define *input*
  (parse-advent input))

(define-record-type decks
  (fields player-1 player-2))

(define start
  (make-decks (take-while (compose not (curry eq? 'Player))
			  (list-tail *input* 2))
	      (list-tail (drop-while (compose not (curry eq? 'Player))
				     (list-tail *input* 2))
			 2)))

(define (score cards)
  (fold-left + 0
	     (map *
		  cards
		  (reverse (cdr (iota (1+ (length cards))))))))

(define (combat game)
  (match game
    (($ decks (a p1 ...) (b p2 ...))
     (if (< a b)
	 (combat (make-decks p1 `(,@p2 ,b ,a)))
	 (combat (make-decks `(,@p1 ,a ,b) p2))))
    (($ decks '() p2) `(player-2 ,(score p2)))
    (($ decks p1 '()) `(player-1 ,(score p1)))))

(define (recursive-combat game)
  (define history
    (make-hashtable equal-hash equal?))
  (let lp ((game game)
	   (n (length (decks-player-1 game)))
	   (m (length (decks-player-2 game))))
    (match game
      (($ decks (a p1 ...) (b p2 ...))
       (let* ((state `(,(cons a p1) ,(cons b p2)))
	      (previously? (hashtable-contains? history state)))
	 (hashtable-set! history state #t)
	 (cond
	  (previously? `(player-1 ,(score (cons a p1))))
	  ((and (< a n) (< b m))
	   (let ((sub-game
		  (recursive-combat (make-decks (list-head p1 a)
						(list-head p2 b)))))
	     (if (eq? 'player-1 (car sub-game))
		 (lp (make-decks `(,@p1 ,a ,b) p2) (1+ n) (1- m))
		 (lp (make-decks p1 `(,@p2 ,b ,a)) (1- n) (1+ m)))))
	  (else
	   (if (< a b)
	       (lp (make-decks p1 `(,@p2 ,b ,a)) (1- n) (1+ m))
	       (lp (make-decks `(,@p1 ,a ,b) p2) (1+ n) (1- m)))))))
      (($ decks '() p2) `(player-2 ,(score p2)))
      (($ decks p1 '()) `(player-1 ,(score p1))))))
