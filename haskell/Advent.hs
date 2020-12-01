
module Advent
  ( -- raw input strings or bytes
    input'string
  , input'bytes
  , input'ints
  , input'ints2d
  , input'parse
  , input'parse'
    -- parsing ish
  , ints'of'bytes
  , puzzle'file
  , module Advent.Write
  ) where

import Data.ByteString.Lazy (ByteString (..))
import qualified Data.ByteString.Lazy.Char8 as B
import Data.Char
import Data.Maybe
import Data.Functor
import Data.Function
import Text.Trifecta
import Data.List

import System.FilePath.Posix
import Text.Printf

import Advent.Write

type Year = Int
type Day = Int

puzzle'file :: Year -> Day -> FilePath
puzzle'file y d = "input" </> "20" <> show y </> show d <.> "in"

input'string :: Year -> Day -> IO String
input'string = (readFile .) . puzzle'file

input'bytes :: Year -> Day -> IO ByteString
input'bytes = (B.readFile .) . puzzle'file

-- for before a parser is settled, to get useful info
input'parse' :: Parser a -> Year -> Day -> IO (Result a)
input'parse' p y d = parseFromFileEx p (puzzle'file y d)

-- for after it's settled, to live dangerously
input'parse :: Parser a -> Year -> Day -> IO a
input'parse p y d = fromJust <$> parseFromFile p (puzzle'file y d)

ints'of'bytes :: ByteString -> [Int]
ints'of'bytes = unfoldr $ B.readInt . B.dropWhile (not . relevant)
  where relevant c = isDigit c || c == '-'

-- fast ints
input'ints :: Year -> Day -> IO [Int]
input'ints y d = input'bytes y d <&> ints'of'bytes

input'ints2d :: Year -> Day -> IO [[Int]]
input'ints2d y d = input'bytes y d <&> map ints'of'bytes . B.lines
