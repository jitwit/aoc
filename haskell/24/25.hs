{-# language LambdaCase #-}

module Main where

import Data.List
import Advent

main =
  do input <- map (fromEnum.(=='#')) . filter (/='\n') <$> input'string 24 25
     let (keys,locks) = partition ((==1).head.concat) $ chunks 7 $ chunks 5 input
         height = map (pred.sum) . transpose
         chunks n = unfoldr $ \case [] -> Nothing
                                    xs -> Just $ splitAt n xs
     print $ sum [ 1 | h'k <- height <$> keys
                     , h'l <- height <$> locks
                     , all (<=5) $ zipWith (+) h'k h'l ]
