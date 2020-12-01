{-# language TupleSections, LambdaCase #-}

import Advent
import Data.Map.Strict (Map,fromList,fromListWith,keys,(!?),keysSet,size)
import Data.Set (toList,member,insert)
import Data.Ix
import Control.Monad
import Linear

main = do
  worldB <- space0 <$> input'string 19 24
  let worldA = za'of'zb worldB
      partA = biodiversity (firstRepeated worldA)
      partB = size $ (iterate evolve worldB) !! 200
  reportAB partA partB

newtype ZA = ZA (V2 Int) deriving (Ord,Eq)
newtype ZB = ZB (V3 Int) deriving (Ord,Eq)
type Planet p = Map p Int
za = (ZA .) . V2
{-# inline za #-}
zb = ((ZB .) .) . V3
{-# inline zb #-}

evolve :: PlanetCoordinate p => Planet p -> Planet p
evolve s = fromList [ (z,1) | z <- zs, 1 == live'die (ref z s) (ref z c) ]
  where c = count s; zs = toList $ keysSet s <> keysSet c
        {-# inline c #-}
        {-# inline zs #-}
        count = fromListWith (+) . (keys >=> spread)
        {-# inline count #-}
        spread z = (,1) <$> neighbors z
        {-# inline spread #-}

biodiversity :: Planet ZA -> Int
biodiversity p = sum [ 2^(5*y+x) | x <- [0..4], y <- [0..4], ref (za x y) p == 1 ]

firstRepeated :: PlanetCoordinate p => Planet p -> Planet p
firstRepeated p = aux mempty p where
  aux seen p | p `member` seen = p
             | otherwise = aux (insert p seen) (evolve p)

class Ord p => PlanetCoordinate p where
  neighbors :: p -> [p]

instance PlanetCoordinate ZA where
  {-# inline neighbors #-}
  neighbors z = [ za x y | (x,y) <- zs, and (inRange (0,4) <$> [x,y]) ]
    where ZA (V2 x y) = z; zs = [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]

instance PlanetCoordinate ZB where
  {-# inline neighbors #-}
  neighbors z = correct =<< [(x-1,y),(x+1,y),(x,y-1),(x,y+1)] where
    {-# inline correct #-}
    {-# inline lowered #-}
    ZB (V3 l x y) = z
    correct = \case
      (-1,_) -> [zb (l-1) 2 1]
      (_,-1) -> [zb (l-1) 1 2]
      (5,_) -> [zb (l-1) 2 3]
      (_,5) -> [zb (l-1) 3 2]
      (2,2) -> lowered
      (x,y) -> [zb l x y]
    lowered | x == 1 = [ zb (l+1) x 0 | x <- [0..4] ]
            | y == 1 = [ zb (l+1) 0 y | y <- [0..4] ]
            | x == 3 = [ zb (l+1) x 4 | x <- [0..4] ]
            | y == 3 = [ zb (l+1) 4 y | y <- [0..4] ]

space0 :: String -> Planet ZB
space0 s = fromList bugs where
  bugs = [ (zb 0 x y,1) | (y,r) <- zip [0..] (lines s), (x,'#') <- zip [0..] r ]

za'of'zb :: Planet ZB -> Planet ZA
za'of'zb = fromList . map transform . keys where
  transform (ZB (V3 _ x y)) = (za x y,1)

ref :: PlanetCoordinate p => p -> Planet p -> Int
ref z s = maybe 0 id (s !? z)
{-# inline ref #-}

live'die 1 1 = 1
live'die 0 1 = 1
live'die 0 2 = 1
live'die _ _ = 0
{-# inline live'die #-}
