module Main where

import Advent
import Data.Bool
import Data.Function

fuel n = n `div` 3 - 2

fuel_ = fix (\ f n -> bool 0 (n + f (fuel n)) (0 < n) )

main = do masses <- input_ints 19 1
          let gas = fuel <$> masses
          put_report $ Solved (sum gas) (sum $ fuel_ <$> gas)
