require 'tables/dsv'

boxes    =: |: makenum 'x' readdsv '../../input/15/2.in'
wrapping =: (<./+(2*+/))@:(]*1&|.)
ribbon   =: */+(2*+/->./)
partA    =: +/ wrapping boxes
partB    =: +/ ribbon boxes

partA;partB
