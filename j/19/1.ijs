require 'tables/csv'

masses =: makenum readcsv '../../input/19/1.in'

fuel =: -&2@<.@%&3

fuelb =: 0:`(]+(fuelb@fuel))@.(0&<)

+/ @ ([ ,. fuelb"0) @ fuel masses
