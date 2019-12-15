{-# language LambdaCase, TypeSynonymInstances, FlexibleInstances #-}

module Advent.Write
  ( AdventDoc (..)
  , Solution (..)
  , output
  , reportA
  , reportB
  ) where

import Text.PrettyPrint.ANSI.Leijen as PP hiding ((<$>))

data Solution a b = A a | B b | AB a b

class AdventDoc a where
  report :: a -> Doc

instance AdventDoc () where
  report = report . show

instance AdventDoc Int where
  report = int
  
instance AdventDoc Integer where
  report = integer
  
instance AdventDoc Float where
  report = float
  
instance AdventDoc Double where
  report = double

instance AdventDoc String where
  report = string

instance (AdventDoc a, AdventDoc b) => AdventDoc (Solution a b) where
  report = \ case
    A a -> string "Part-A " <> bold (red $ report a)
    B b -> string "Part-B " <> bold (green $ report b)
    AB a b -> vsep $ report <$> [A a,B b]

output :: AdventDoc a => a -> IO ()
output = putDoc . (<>line) . report

reportA :: AdventDoc a => a -> Solution a ()
reportA = A

reportB :: AdventDoc b => b -> Solution () b
reportB = B
