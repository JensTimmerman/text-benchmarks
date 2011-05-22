-- | Main module to run the micro benchmarks
--
module Main
    ( main
    ) where

import Criterion.Main (Benchmark, defaultMain)

import qualified Data.Text.Benchmarks.Micro.Builder as Builder
import qualified Data.Text.Benchmarks.Micro.CaseMap as CaseMap
import qualified Data.Text.Benchmarks.Micro.FileRead as FileRead
import qualified Data.Text.Benchmarks.Micro.StripBrackets as StripBrackets
import qualified Data.Text.Benchmarks.Micro.WordCount as WordCount

main :: IO ()
main = defaultMain benchmarks

benchmarks :: [Benchmark]
benchmarks =
    [ Builder.benchmark
    , CaseMap.benchmark "data/russian.txt"
    , FileRead.benchmark "data/russian.txt"
    , StripBrackets.benchmark "data/russian.txt"
    , WordCount.benchmark "data/russian.txt"
    ]
