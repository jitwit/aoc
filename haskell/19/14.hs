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

main = output . solve =<< input'parse parse'rules 19 14

solve :: [Reaction Chemical] -> Solution Int Int
solve rules = AB (ore 1) (bin 1 (10^12)) where
  chemicals = chemical'order rules
  factory = nano'factory rules & at "ORE" ?~ (0,0,[])
  ore = produce'fuel chemicals factory
  bin lo hi | hi < lo = hi
            | ore m <= 10^12 = bin (m+1) hi
            | otherwise = bin lo (m-1)
            where m = (lo + hi)`div`2

produce'fuel :: [Chemical] -> NanoFactory Chemical -> Int -> Int
produce'fuel chemicals factory n = final ^?! ix "ORE" . _1 where
  start = factory & ix "FUEL" . _1 .~ n
  final = foldr produce start chemicals where
    produce chemical factory = foldr update factory dependencies where
      update (n,c) = ix c . _1 +~ n * times
      times = (need+make-1)`div`make
      (need,make,dependencies) = factory ^?! ix chemical

chemical'order :: Ord a => [Reaction a] -> [a]
chemical'order = fromRight (error "oops") . topSort . graph'of'recipes

graph'of'recipes :: Ord a => [Reaction a] -> AdjacencyMap a
graph'of'recipes = edges . (edges'of'recipe =<<) where
  edges'of'recipe (ingredients, (_,o)) = [ (i,o) | (_,i) <- ingredients ]

nano'factory :: Ord a => [Reaction a] -> NanoFactory a
nano'factory reactions = fromList [ (c,(0,n,is)) | (is, (n,c)) <- reactions ]

parse'rules :: TokenParsing m => m [Reaction Chemical]
parse'rules = sepBy parse'rule newline <* eof where
  parse'rule = (,) <$> commaSep parse'ingredient <* string " => " <*> parse'ingredient
  parse'ingredient = wrap <$> integer <*> many letter where
  wrap n s = (fromIntegral n, s)
