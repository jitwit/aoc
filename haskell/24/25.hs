{-# language LambdaCase #-}

module Main where

import Data.List
import Advent

chunks n = unfoldr $ \case [] -> Nothing
                           xs -> Just $ splitAt n xs

main =
  do input <- map (fromEnum.(=='#')) . filter (/='\n') <$> input'string 24 25
     let (keys,locks) = partition ((==1).head.concat) $ chunks 7 $ chunks 5 input
         heights = map (map (pred.sum) . transpose)
     print $ sum [ 1 | k <- heights keys
                     , l <- heights locks
                     , all (<=5) $ zipWith (+) k l ]
