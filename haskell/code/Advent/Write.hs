{-# language LambdaCase #-}

module Advent.Write
  ( AdventDoc (..)
  , Solution (..)
  , put_report
  ) where

import Text.PrettyPrint.ANSI.Leijen as PP hiding ((<$>))

data Solution a b = PartA a | PartB b | Solved a b

class AdventDoc a where
  report :: a -> Doc

instance AdventDoc Int where
  report = int
  
instance AdventDoc Integer where
  report = integer
  
instance AdventDoc Float where
  report = float
  
instance AdventDoc Double where
  report = double

instance (AdventDoc a, AdventDoc b) => AdventDoc (Solution a b) where
  report = \ case
    PartA a -> string "PartA:" <> space <> report a
    PartB b -> string "PartB:" <> space <> report b
    Solved a b -> vsep $ report <$> [PartA a,PartB b]
      

report' = undefined

put_report :: AdventDoc a => a -> IO ()
put_report = putDoc . (<>line) . report
