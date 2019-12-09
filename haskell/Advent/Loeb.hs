module Advent.Loeb
  ( loeb
  , fibs
  ) where

instance Num a => Num (b -> a) where
  f + g = \x -> f x + g x
  f * g = \x -> f x * g x
  abs f = abs . f
  signum = (.) signum
  negate = (.) negate
  fromInteger = const . fromInteger

-- ($) : (a -> b) -> a -> b
loeb :: Functor p => p (p x -> x) -> p x
loeb ppx = tie where tie = ($tie) <$> ppx

fibs :: [Integer]
fibs = loeb $ fib <$> [0..] where
  fib 0 = 0
  fib 1 = 1
  fib n = (flip (!!) (n-1)) + (flip (!!) (n-2))
