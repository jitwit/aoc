(include "~/code/advent/code/biblio.ss")

(import (euler))

(define masses
  (parse-advent input))

(define (fuel mass)
  (- (fx/ mass 3) 2))

(define (part-a)
  (apply + (map fuel masses)))

(define (fuel+ mass)
  (if (< 0 mass)
      (+ mass (fuel+ (fuel mass)))
      0))

(define (part-b)
  (apply + (map (compose fuel+ fuel) masses)))
