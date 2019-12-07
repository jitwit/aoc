clean :
	find . -name "*~" -exec rm {} \;
	find . -name "*.hi" -exec rm {} \;
	find . -name "*.o" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf dist-newstyle

.PHONY : clean
