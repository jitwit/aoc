input =: 1!:1 < '../../input/15/8.in'

NB. how to get lines? why doesn't +/ @ unescape_def work? how to
NB. group?
unescape =: >:@:e.&'"\'
partB    =: (+/@unescape)-#

examples =: < L:0 ('""' ; '"abc"' ; '"aaa\"aaa"' ; '"\x28"')
([,.(partB L:0)) examples
partB input NB. not quite right


