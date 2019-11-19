(import (srfi :13)
	(srfi :14)
        (sxml-mini)
	(euler)
        (matchable))

(print-gensym #f)

(define source-files
  '("code/biblio.ss"
    "code/outils.ss"
    "code/style-sheet.ss"))

(for-all load source-files)
