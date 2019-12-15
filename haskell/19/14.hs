{-# language GADTs, OverloadedStrings, TupleSections #-}

import Algebra.Graph.AdjacencyMap.Algorithm
import Algebra.Graph.AdjacencyMap
import Data.Map.Lens
import Control.Lens
import Data.Map (Map)
import Text.Trifecta
import Data.Either
import Advent

type Measurement a = (Int,a)
type NanoFactory a = Map a (Int,Int,[Measurement a])
type Chemical = String
data Recipe a = Recipe [Measurement a] (Measurement a)

main = do
  Just rules <- parseFromFile parse_rules (puzzle_file 19 14)
  output $ solve rules

solve :: [Recipe Chemical] -> Solution Int Int
solve rules = AB (fuel 1) (bin 1 (10^12)) where
  chemicals = chemical_order rules; factory = nano_factory rules
  fuel = produce_fuel chemicals factory
  bin lo hi | hi < lo = hi
            | fuel m <= 10^12 = bin (m+1) hi
            | otherwise = bin lo (m-1)
            where m = (lo + hi) `div` 2

produce_fuel :: [Chemical] -> NanoFactory Chemical -> Int -> Int
produce_fuel chemicals factory n = final ^?! ix "ORE" . _1 where
  start = factory & at "ORE" ?~ (0,0,[]) & ix "FUEL" . _1 .~ n
  final = foldl consume_rule start chemicals where
    consume_rule factory chemical =
      let (need,make,xs) = factory ^?! ix chemical
          times = (need+make-1)`div`make
       in foldl (\f (n,c) -> f & ix c . _1 +~ n * times) factory xs

chemical_order :: Ord a => [Recipe a] -> [a]
chemical_order = fromRight (error "oops") . topSort . graph_of_recipes

graph_of_recipes :: Ord a => [Recipe a] -> AdjacencyMap a
graph_of_recipes = edges . (edges_of_recipe =<<) where
  edges_of_recipe (Recipe ingredients (_,out)) = (out,) . snd <$> ingredients

nano_factory :: Ord a => [Recipe a] -> NanoFactory a
nano_factory rules = shifted_rules & toMapOf (folded.ifolded) where
  shifted_rules = [ (c,(0,n,is)) | Recipe is (n,c) <- rules ]

parse_rules :: TokenParsing m => m [Recipe Chemical]
parse_rules = sepBy parse_rule newline <* eof where
  parse_rule = Recipe <$> commaSep parse_ingredient <* string " => " <*> parse_ingredient
  parse_ingredient = wrap <$> integer <*> many letter where
  wrap n s = (fromIntegral n, s)
