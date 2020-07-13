(load "~/code/aoc/load.ss")
(advent-year 19)
(advent-day 15)

(define program
  (with-input-from-file (advent-file) parse-intcode))

(define proggl
  (with-input-from-file "gl15.txt" parse-intcode))

(define-values (north south east west) (values 1 2 4 3))
(define-values (wall moved oxygen-system) (values 0 1 2))

(define (dir->instr z)
  (match z (1 east) (-1 west) (0+i north) (0-i south)))

(define (fps->duration fps)
  (make-time 'time-duration
	     (ceiling (/ (expt 10 9) fps))
	     0))

(define (explore program animated? fps)
  (define world (make-eqv-hashtable))
  (define part-a #f)
  (define tank #f)
  (let walk ((Q (q:snocq q:empty (list 0 0 (intcode program)))))
    (if (q:empty? Q)
	(values part-a
		(apply max
		       (vector->list
			(hashtable-values
			 (bfs-result-distances
			  (bfs tank
			       (lambda (z)
				 (filter (lambda (z)
					   (memq (hashtable-ref world z 'idk)
						 '(open tank)))
					 (grid4 z)))))))))
	(match (q:headq Q)
	  ((d x droid)
	   (when animated?
	     (newline) (showme world x) (newline)
	     (sleep (fps->duration fps)))
	   (let ((d (+ d 1)))
	     (let adj ((zs (grid4 x)) (Q (q:tailq Q)))
	       (match zs
		 (() (walk Q))
		 ((z zs ...)
		  (if (hashtable-ref world z #f)
		      (adj zs Q)
		      (let ((droid (fork-intcode droid)))
			(send-input droid (dir->instr (- z x)))
			(run-until-halt droid)
			(match (read-output droid)
			  ((0)
			   (hashtable-set! world z 'wall)
			   (adj zs Q))
			  ((1)
			   (hashtable-set! world z 'open)
			   (adj zs (q:snocq Q (list d z droid))))
			  ((2)
			   (hashtable-set! world z 'tank)
			   (set! part-a d)
			   (set! tank z)
			   (adj zs (q:snocq Q (list d z droid))))
			  (else (error 'oops "no output or something" out))))))))))))))

(define (showme g loc)
  (define-values (xlo xhi ylo yhi)
    (bounding-box-C (cons 0 (vector->list (hashtable-keys g)))))
  (do ((i (1- xlo) (1+ i)))
      ((> i (1+ xhi)))
    (do ((j (1- ylo) (1+ j)))
        ((> j (1+ yhi)) (newline))
      (let ((z (make-rectangular i j)))
        (cond ((eqv? z loc)
               (display-with-foreground 'red #\@))
              (else
               (match (hashtable-ref g (make-rectangular i j) 'idk)
                 ('idk (display-with-foreground 'blue #\?))
                 ('wall (display-with-foreground 'green #\#))
                 ('open (display #\space))
                 ('tank (display-with-foreground 'red #\O)))))))))
