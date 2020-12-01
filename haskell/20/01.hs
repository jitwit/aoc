module Main where

import Advent
import Data.List

main =
  do expenses <- input'ints 20 1
     let a = head [ x*y | x:ys <- tails expenses, y <- ys, x+y == 2020 ]
     let b = head [ x*y*z | x:ys <- tails expenses, y:zs <- tails ys, z <- zs
                          , x+y+z == 2020 ]
     output $ AB a b
