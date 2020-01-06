{-# language GADTs, OverloadedStrings, TupleSections #-}

import Algebra.Graph.AdjacencyMap.Algorithm
import Algebra.Graph.AdjacencyMap
import Control.Lens
import Data.Map (Map,fromList)
import Text.Trifecta
import Data.Either
import Advent

type Chemical = String
type Quantity a = (Int,a)
type Reaction a = ([Quantity a], Quantity a)
type NanoFactory a = Map a (Int,Int,[Quantity a])

main = output . solve =<< input_parse parse_rules 19 14

solve :: [Reaction Chemical] -> Solution Int Int
solve rules = AB (ore 1) (bin 1 (10^12)) where
  chemicals = chemical_order rules
  factory = nano_factory rules & at "ORE" ?~ (0,0,[])
  ore = produce_fuel chemicals factory
  bin lo hi | hi < lo = hi
            | ore m <= 10^12 = bin (m+1) hi
            | otherwise = bin lo (m-1)
            where m = (lo + hi)`div`2

produce_fuel :: [Chemical] -> NanoFactory Chemical -> Int -> Int
produce_fuel chemicals factory n = final ^?! ix "ORE" . _1 where
  start = factory & ix "FUEL" . _1 .~ n
  final = foldr produce start chemicals where
    produce chemical factory = foldr update factory dependencies where
      update (n,c) = ix c . _1 +~ n * times
      times = (need+make-1)`div`make
      (need,make,dependencies) = factory ^?! ix chemical

chemical_order :: Ord a => [Reaction a] -> [a]
chemical_order = fromRight (error "oops") . topSort . graph_of_recipes

graph_of_recipes :: Ord a => [Reaction a] -> AdjacencyMap a
graph_of_recipes = edges . (edges_of_recipe =<<) where
  edges_of_recipe (ingredients, (_,o)) = [ (i,o) | (_,i) <- ingredients ]

nano_factory :: Ord a => [Reaction a] -> NanoFactory a
nano_factory reactions = fromList [ (c,(0,n,is)) | (is, (n,c)) <- reactions ]

parse_rules :: TokenParsing m => m [Reaction Chemical]
parse_rules = sepBy parse_rule newline <* eof where
  parse_rule = (,) <$> commaSep parse_ingredient <* string " => " <*> parse_ingredient
  parse_ingredient = wrap <$> integer <*> many letter where
  wrap n s = (fromIntegral n, s)
