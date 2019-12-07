irc-leaderboard-uri ::= https://adventofcode.com/2019/leaderboard/private/view/382266.json
haskell-leaderboard-uri ::= https://adventofcode.com/2019/leaderboard/private/view/43100.json
exercism-leaderboard-uri ::= https://adventofcode.com/2019/leaderboard/private/view/640670.json
leaderboards ::= output/irc-leaderboard.sexp output/haskell-leaderboard.sexp output/exercism-leaderboard.sexp

leaderboards : 
	make $(leaderboards)

output/irc-leaderboard.json : code/secret.sh
	sh $< $(irc-leaderboard-uri) $@

output/haskell-leaderboard.json : code/secret.sh
	sh $< $(haskell-leaderboard-uri) $@

output/exercism-leaderboard.json : code/secret.sh
	sh $< $(exercism-leaderboard-uri) $@

output/%.sexp : output/%.json
	sexp_of_json < $< > $@

input/%/%.in :
	echo $@

clean :
	find . -name "*~" -exec rm {} \;
	find . -name "*.hi" -exec rm {} \;
	find . -name "*.o" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf dist-newstyle

.PHONY : clean leaderboards output/exercism-leaderboard.json
