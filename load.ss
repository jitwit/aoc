(import (srfi :1)
        (srfi :13)
        (srfi :14)
        (prefix (patricia) t:)
        (prefix (patricia-set) s:)
        (prefix (kd-tree) kd:)
        (prefix (batched-queue) q:)
        (prefix (pairing-heap) h:)
        (prefix (alga) g:)
;;        (sxml-mini)
        (euler)
        (matchable)
	(intcode))

(print-gensym #f)

(define (advent-file-path file)
  (string-append "~/code/aoc/code/" file))

(define source-files
  (map advent-file-path '("biblio.ss" "outils.ss" "graph.ss" "svg.ss")))

(for-each load source-files)
