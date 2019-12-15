
module Advent
  ( -- raw input strings or bytes
    input_string
  , input_bytes
  , input_ints
  , input_ints2d
  , input_parse
  , input_parse'
    -- parsing ish
  , ints_of_bytes
  , puzzle_file
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

puzzle_file :: Year -> Day -> FilePath
puzzle_file y d = chez_advent </> "input" </> show y </> show d <.> "in"
  where chez_advent = "/Users/jrn/code/advent"

input_string :: Year -> Day -> IO String
input_string = (readFile .) . puzzle_file

input_bytes :: Year -> Day -> IO ByteString
input_bytes = (B.readFile .) . puzzle_file

-- for before a parser is settled, to get useful info
input_parse' :: Parser a -> Year -> Day -> IO (Result a)
input_parse' p y d = parseFromFileEx p (puzzle_file y d)

-- for after it's settled, to live dangerously
input_parse :: Parser a -> Year -> Day -> IO a
input_parse p y d = fromJust <$> parseFromFile p (puzzle_file y d)

ints_of_bytes :: ByteString -> [Int]
ints_of_bytes = unfoldr $ B.readInt . B.dropWhile (not . relevant)
  where relevant c = isDigit c || c == '-'

-- fast ints
input_ints :: Year -> Day -> IO [Int]
input_ints y d = input_bytes y d <&> ints_of_bytes

input_ints2d :: Year -> Day -> IO [[Int]]
input_ints2d y d = input_bytes y d <&> map ints_of_bytes . B.lines
