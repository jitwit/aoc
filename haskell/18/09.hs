{-# language FlexibleInstances, MultiParamTypeClasses #-}
{-# language TemplateHaskell, LambdaCase #-}

module Main where

import qualified Data.FingerTree as F
import Data.FingerTree (FingerTree, Measured)
import Data.Foldable
import Data.Monoid
import qualified Data.IntMap as M
import Control.Lens
import Control.Monad
import Control.Applicative
import Advent

newtype Marble a = Marble { marble :: a }
  deriving (Eq)

instance Measured (Sum Int) (Marble a) where
  measure _ = Sum 1

instance Show a => Show (Marble a) where
  show = show . marble

data Marble'Table a = Marble'Table
  { _ptr :: Int,
    _table :: FingerTree (Sum Int) (Marble a),
    _score :: M.IntMap (Sum Int),
    _next :: Int }

instance Show a => Show (Marble'Table a) where
  show (Marble'Table p t s n) = unwords [show p, show $ toList t]

makeLenses ''Marble'Table

step :: Marble'Table Int -> Marble'Table Int
step m@(Marble'Table p t s n)
  | p > 0 && 0 == p `mod` 23 = m
    & ptr .~ p''
    & next +~ 1
    & score %~ M.alter (\x -> (+scr) <$> x <|> Just scr) plr
    & table .~ t''
  | otherwise = m
    & ptr .~ p'
    & next +~ 1
    & table .~ t'
  where p' = 1+(p+1)`mod`(length t)
        (t'l, t'r) = F.split (>Sum p') t
        t' = (t'l F.|> Marble n) F.>< t'r
        plr = 0
        p'' = (p-7)`mod`(length t)
        (t''l, t''r) = F.split (>Sum p'') t
        scr = Sum $ n + n'
        (n',t'') = case F.viewl t''r of
          F.EmptyL -> case F.viewr t''l of
            F.EmptyR -> error "impossible!!"
            t''' F.:> Marble x -> (x,t''' F.>< t''r)
          Marble x F.:< t''' -> (x,t''l F.>< t''')

start :: Marble'Table Int
start = Marble'Table 0 (F.singleton $ Marble 0) mempty 1

main = pure ()
