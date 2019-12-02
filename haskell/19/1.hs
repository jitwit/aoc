module Main where

import Data.Function
import Advent

fuel n = n `div` 3 - 2

fuel_ = fix (\ f n -> if 0 < n then f (fuel n) + n else 0 )

main =
  do masses <- input_ints 19 1
     let gas = fuel <$> masses
     output $ AB (sum gas) (sum $ fuel_ <$> gas)
