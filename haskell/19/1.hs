{-# language TypeApplications #-}

module Main where

import Data.Bool

fuel n = n`div`3 - 2

fuel_ n = bool 0 (n + fuel_ (fuel n)) (0 < n)

partA = sum . map fuel
partB = sum . map (fuel_ . fuel)

main = do masses <- map (read @ Int) . words <$> readFile "../../input/19/1.in"
          print $ partA masses
          print $ partB masses
