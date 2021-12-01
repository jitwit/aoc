.PHONY : help fetch clean haskell very-clean leaderboard.json

y = 2021
d = 1

help :
	echo "idk"

fetch :
	jconsole aoc.ijs -js "exit (aoc :: 1:) $(y) $(d)"

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
	rm -rf dist
