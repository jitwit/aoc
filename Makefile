clean :
	find . -name "*~" -exec rm {} \;
	find . -name "*.hi" -exec rm {} \;
	find . -name "*.o" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	find . -name "*.tex" -exec rm {} \;
	find . -name "*.pdf" -exec rm {} \;

very-clean :
	make clean
	rm -rf dist-newstyle

haskell :
	cabal build

.PHONY : clean haskell very-clean
