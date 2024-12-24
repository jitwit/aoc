module Main where

import Algebra.Graph.AdjacencyMap
import qualified Data.Set as S
import Data.Tuple
import Data.List
import Data.Ord
import Advent

adj g = S.elems . postSet g

part'a g = length $ nub triangles where
  triangles = nub [ sort [a,b,c]
                  | a@('t':_) <- vertexList g
                  , b <- adj a g
                  , c <- adj b g
                  , hasEdge c a g ]

part'b g = intercalate "," $ max'clique where
  max'clique = maximumBy (comparing length) cliques
  cliques = [ expand'clique g v | v <- vertexList g ]

expand'clique g x = foldr expand [x] $ adj x g where
  expand v c | all id [ hasEdge v x g | x <- c ] = v:c
             | otherwise = c

main =
  do ls <- map (\l -> (take 2 l, drop 3 l)) . lines <$> input'string 24 23
     let g = edges $ ls ++ map swap ls
     output $ AB (part'a g) (part'b g)
