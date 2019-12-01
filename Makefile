clean :
	find . -name "*~" -exec rm {} \;
	find . -name "*.hi" -exec rm {} \;
	find . -name "*.o" -exec rm {} \;

.PHONY : clean


