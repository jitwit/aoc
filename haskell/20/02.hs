module Main where

import Advent
import Data.Ix
import Data.List
import Text.Trifecta

parse :: Parser [Int]
parse = do
  lo <- fromIntegral <$> decimal <* char '-'
  hi <- fromIntegral <$> decimal <* space
  k <- anyChar <* string ": "
  w <- many letter
  let part'a = fromEnum $ inRange (lo,hi) $ sum $ fromEnum . (k==) <$> w
  let part'b = fromEnum $ 1 == sum (fromEnum . (k==) . (w!!) <$> [lo-1,hi-1])
  return [part'a,part'b]

main =
  do xs <- input'parse (sepEndBy parse newline) 20 2
     let [a,b] = map sum $ transpose xs
     output $ AB a b
