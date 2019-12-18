input =: freads < '~/code/advent/input/15/8.in'

NB. how to get lines? why doesn't +/ @ unescape_def work? how to
NB. group?
unescape =: >:@:e.&'"\'
partB    =: (+/@unescape)-#

examples =: ('""' ; '"abc"' ; '"aaa\"aaa"' ; '"\x28"')
([,.(partB L:0)) examples
partB input NB. not quite right


