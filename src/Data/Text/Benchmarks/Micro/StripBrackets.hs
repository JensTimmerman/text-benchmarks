-- | Program to replace everything between brackets by spaces
--
-- This program was originally contributed by Petr Prokhorenkov.
--
module Data.Text.Benchmarks.Micro.StripBrackets
    ( benchmark
    ) where
     
import Criterion.Main (Benchmark, bench)
import qualified Data.Text as T

import Data.Text.Benchmarks.Micro.Util

benchmark :: FilePath -> Benchmark
benchmark = bench "StripBrackets" . withUtf8File stripBrackets

stripBrackets :: T.Text -> T.Text
stripBrackets = snd . T.mapAccumL f (0 :: Int)
  where
    f depth c =
        let depth' = depth + d' c
            c' | depth > 0 || depth' > 0 = ' '
               | otherwise = c
        in (depth', c')

    d' '{' = 1
    d' '[' = 1
    d' '}' = -1
    d' ']' = -1
    d' _   = 0
