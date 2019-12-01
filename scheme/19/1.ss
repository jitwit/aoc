(include "~/code/advent/code/biblio.ss")

(define masses
  (parse-advent input))

(define (fuel mass)
  (- (fx/ mass 3) 2))

(define (part-a)
  (apply + (map fuel masses)))

(define (fuel+ mass)
  (letrec ((%fuel (lambda (mass)
                    (if (< 0 mass)
                        (+ mass (%fuel (fuel mass)))
                        0))))
    (%fuel (fuel mass))))

(define (part-b)
  (apply + (map fuel+ masses)))
