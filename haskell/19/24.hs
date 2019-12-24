{-# language TupleSections, LambdaCase, TypeSynonymInstances, BangPatterns #-}

import Advent
import Data.Map.Strict (Map,fromList,fromListWith,keys,(!?),keysSet,size)
import Data.Set (toList,member,insert)
import Data.Ix
import Control.Monad
import Linear

newtype ZA = ZA (V2 Int) deriving (Ord,Eq)
newtype ZB = ZB (V3 Int) deriving (Ord,Eq)
type Planet p = Map p Int

main = do
  worldB <- space0 <$> input_string 19 24
  let worldA = za_of_zb worldB
      partA = biodiversity (pa worldA)
      partB = size $ (iterate evolve worldB) !! 200
  output $ AB partA partB

evolve :: PlanetCoordinate p => Planet p -> Planet p
evolve s = fromList [ (z,b) | z <- zs, let b = live_die (ref z s) (ref z c), b == 1 ]
  where c = count s; zs = toList $ keysSet s <> keysSet c
        count = fromListWith (+) . (keys >=> spread)
        spread z = (,1) <$> bordering z

biodiversity :: Planet ZA -> Int
biodiversity p = sum [ 2^(5*y+x) | x <- [0..4], y <- [0..4], ref (ZA (V2 x y)) p == 1 ]

pa :: PlanetCoordinate p => Planet p -> Planet p
pa p = aux mempty p where
  aux seen p | p `member` seen = p
             | otherwise = aux (insert p seen) (evolve p)

class Ord p => PlanetCoordinate p where
  bordering :: p -> [p] 

instance PlanetCoordinate ZA where
  bordering za = [ ZA (V2 x y) | (x,y) <- zs, inRange (0,4) x, inRange (0,4) y ]
    where ZA (V2 x y) = za; zs = [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]

instance PlanetCoordinate ZB where
  bordering zb = ZB <$> (correct =<< [(x-1,y),(x+1,y),(x,y-1),(x,y+1)]) where
    ZB (V3 l x y) = zb
    correct = \case
      ((-1), _) -> [V3 (l-1) 2 1]
      (_, (-1)) -> [V3 (l-1) 1 2]
      (5, _) -> [V3 (l-1) 2 3]
      (_, 5) -> [V3 (l-1) 3 2]
      (2, 2) -> lowered
      (x,y) -> [V3 l x y]
    lowered | x == 1 = [ V3 (l+1) x 0 | x <- [0..4] ]
            | y == 1 = [ V3 (l+1) 0 y | y <- [0..4] ]
            | x == 3 = [ V3 (l+1) x 4 | x <- [0..4] ]
            | y == 3 = [ V3 (l+1) 4 y | y <- [0..4] ]
            | otherwise = error "oops"

space0 :: String -> Planet ZB
space0 s = fromList bugs where
  bugs = [ (ZB (V3 0 x y),1) | (y,r) <- zip [0..] (lines s), (x,'#') <- zip [0..] r ]

za_of_zb :: Planet ZB -> Planet ZA
za_of_zb = fromList . map transform . keys where
  transform (ZB (V3 _ x y)) = (ZA (V2 x y),1)

ref :: PlanetCoordinate p => p -> Planet p -> Int
ref z s = maybe 0 id (s !? z)

live_die 1 1 = 1
live_die 0 1 = 1
live_die 0 2 = 1
live_die _ _ = 0
