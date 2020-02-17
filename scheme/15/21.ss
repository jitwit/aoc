(load "~/code/advent/load.ss")
(advent-year 15)
(advent-day 21)

(define weapons
  (let loop ((items (with-input-from-file "weapons.txt" input)))
    (match items
      (('Weapons: 'Cost 'Damage 'Armor xs ...)
       (cons (n-tuples 4 (list-head xs 20))
             (loop (list-tail xs 20))))
      (('Armor: 'Cost 'Damage 'Armor xs ...)
       (cons (n-tuples 4 (list-head xs 20))
             (loop (list-tail xs 20))))
      (('Rings: 'Cost 'Damage 'Armor xs ...)
       (list (map (lambda (ring)
                    (cons (car ring) (list-tail ring 2)))
                  (n-tuples 5 xs))))
      (() '()))))

(define boss '(Boss 100 8 2))
(define (cost item) (list-ref item 1))
(define (damage item) (list-ref item 2))
(define (armor item) (list-ref item 3))
(define (hp who) (list-ref who 1))
(define (armor item) (list-ref item 3))

(define options
  (list (car weapons)
        (cons '(None 0 0 0) (cadr weapons))
        (cons '((None 0 0 0))
              (combinations (cons '(None 0 0 0) (caddr weapons)) 2))))

(define (combine x y)
  (map + x y))

(define equippings
  (map (lambda (option)
         (match option
           ((w a rs)
            (cons* 'LittleHenryCase
                   (map +
                        (cdr w)
                        (cdr a)
                        (apply map + (map cdr rs)))))))
       (cartesian-product options)))

(define (rounds p q)
  (ceiling (/ (hp q) (max 1 (- (damage p) (armor q))))))

(define (battle p q)
  (car (if (< (rounds q p) (rounds p q)) q p)))

(define battles
  (map (lambda (e)
         (match e
           ((lhc cost d a)
            (battle (list lhc 100 d a) boss))))
       equippings))

(define (partA)
  (apply min
         (filter-map (lambda (winner e)
                       (and (eq? 'LittleHenryCase winner)
                            (cost e)))
                     battles
                     equippings)))

(define (partB)
  (apply max
         (filter-map (lambda (winner e)
                       (and (eq? 'Boss winner)
                            (cost e)))
                     battles
                     equippings)))
