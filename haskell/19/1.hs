module Main where

import Advent

fuel n = n `div` 3 - 2

fuel_ n = if 0 < n then 0 else n + fuel_ (fuel n)

partA = sum . map fuel
partB = sum . map (fuel_ . fuel)

main = do masses <- input_ints 19 1
          print $ partA masses
          print $ partB masses
