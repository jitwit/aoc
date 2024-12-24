module Main where

import Algebra.Graph.AdjacencyMap
import qualified Data.Set as S
import Data.Tuple
import Data.List
import Data.Ord
import Advent

part'a g = length $ nub triangles where
  triangles = [ sort [a,b,c]
              | a@('t':_) <- vertexList g
              , b <- S.elems $ postSet a g
              , c <- S.elems $ postSet b g
              , hasEdge c a g ]

part'b g = intercalate "," $ S.elems max'clique where
  max'clique = maximumBy (comparing length) cliques
  expand v c | all (`S.member` postSet v g) c = S.insert v c
             | otherwise = c
  expand'clique g x = foldr expand (S.singleton x) $ postSet x g
  cliques = [ expand'clique g v | v <- vertexList g ]

main =
  do ls <- map (\l -> (take 2 l, drop 3 l)) . lines <$> input'string 24 23
     let g = edges $ ls ++ map swap ls
     output $ AB (part'a g) (part'b g)
