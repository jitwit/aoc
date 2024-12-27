module Main where

import Algebra.Graph.AdjacencyMap; import qualified Data.Set as S
import Data.List; import Data.Ord; import Advent

part'a g = length $ nub [ sort [a,b,c]
                        | a@('t':_) <- vertexList g
                        , b <- S.elems $ postSet a g
                        , c <- S.elems $ postSet b g
                        , hasEdge c a g ]

part'b g = intercalate "," $ S.elems $ maximumBy (comparing length) cliques where
  cliques = expand'clique <$> vertexList g
  expand'clique x = foldr expand (S.singleton x) $ postSet x g
  expand v c | all (`S.member` postSet v g) c = S.insert v c
             | otherwise = c

main = do ls <- map (fmap tail.splitAt 2) . lines <$> input'string 24 23
          let g = edges $ ls ++ map (\(x,y) -> (y,x)) ls
          reportAB (part'a g) (part'b g)
