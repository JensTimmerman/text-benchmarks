-- | Main module to run the benchmarks
--
module Main
    ( main
    ) where

import Criterion.Main (defaultMain)

import Data.Text.Benchmarks.Types
import qualified Data.Text.Benchmarks.Programs.CaseMap as CaseMap


main :: IO ()
main = defaultMain $ toBenchmarks inputSpec

inputSpec :: InputSpec
inputSpec =
    [ (CaseMap.benchmark, ["data/english.txt"])
    ]
