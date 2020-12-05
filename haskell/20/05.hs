{-# language OverloadedStrings #-}

module Main where

import Advent
import qualified Data.Array.Unboxed as A
import qualified Data.ByteString.Lazy.Char8 as B

seat :: B.ByteString -> Int
seat = B.foldl' (\x c -> 2*x + fromEnum (B.elem c "BR")) 0

main =
  do ids <- map seat . B.lines <$> input'bytes 20 5
     let a = maximum ids
     let seen :: A.UArray Int Bool
         seen = A.accumArray (&&) True (0,1023) $ zip ids (repeat False)
     let b = head [ j | j <- [a,a-1..], seen A.! j ]
     output $ AB a b
