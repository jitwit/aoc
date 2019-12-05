irc-leaderboard-uri ::= https://adventofcode.com/2019/leaderboard/private/view/382266.json
haskell-leaderboard-uri ::= https://adventofcode.com/2019/leaderboard/private/view/43100.json
leaderboard-json ::= output/irc-leaderboard.json output/haskell-leaderboard.json

leaderboards : 
	make $(leaderboard-json)

output/irc-leaderboard.json : code/secret.sh
	sh $< $(irc-leaderboard) $@

output/haskell-leaderboard.json : code/secret.sh
	sh $< $(haskell-leaderboard) $@

input/%/%.in :
	echo $@

clean :
	find . -name "*~" -exec rm {} \;
	find . -name "*.hi" -exec rm {} \;
	find . -name "*.o" -exec rm {} \;
	find . -name "*.html" -exec rm {} \;
	rm -rf dist-newstyle

.PHONY : clean output/irc-leaderboard.json output/haskell-leaderboard.json leaderboards


