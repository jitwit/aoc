(import (srfi :13)
        (srfi :14)
        (prefix (patricia) t:)
        (prefix (patricia-set) s:)
        (prefix (kd-tree) kd:)
        (prefix (batched-queue) q:)
        (prefix (pairing-heap) h:)
        (prefix (alga) g:)
        (charset)
        (vector)
        (sxml-mini)
        (euler)
        (matchable))

(print-gensym #f)

(define (advent-file-path file)
  (string-append "~/code/advent/code/" file))

(define source-files
  (map advent-file-path '("biblio.ss" "outils.ss" "graph.ss" "intcode.ss" "svg.ss")))

(for-all load source-files)
