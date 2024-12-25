{-# language LambdaCase #-}

module Main where

import Data.List
import Advent

main =
  do input <- map (fromEnum.(=='#')) . filter (/='\n') <$> input'string 24 25
     let chunks n = unfoldr $ \case [] -> Nothing; xs -> Just $ splitAt n xs
         (keys,locks) = partition ((==1).head.concat) $ chunks 7 $ chunks 5 input
     print $ sum [ 1 | h'k <- map (pred.sum) . transpose <$> keys
                     , h'l <- map (pred.sum) . transpose <$> locks
                     , all (<=5) $ zipWith (+) h'k h'l ]
