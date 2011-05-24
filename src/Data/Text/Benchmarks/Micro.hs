-- | Main module to run the micro benchmarks
--
module Main
    ( main
    ) where

import Criterion.Main (Benchmark, defaultMain)

import System.IO (IOMode (WriteMode), openFile, hSetEncoding, utf8)

import qualified Data.Text.Benchmarks.Micro.Builder as Builder
import qualified Data.Text.Benchmarks.Micro.CaseMap as CaseMap
import qualified Data.Text.Benchmarks.Micro.Cut as Cut
import qualified Data.Text.Benchmarks.Micro.DecodeUtf8 as DecodeUtf8
import qualified Data.Text.Benchmarks.Micro.FileRead as FileRead
import qualified Data.Text.Benchmarks.Micro.StripBrackets as StripBrackets
import qualified Data.Text.Benchmarks.Micro.WordCount as WordCount

main :: IO ()
main = benchmarks >>= defaultMain

benchmarks :: IO [Benchmark]
benchmarks = do
    sink <- openFile "/dev/null" WriteMode
    hSetEncoding sink utf8
    return $
        [ Builder.benchmark
        , CaseMap.benchmark "data/russian.txt"
        , Cut.benchmark "data/russian.txt" sink 30 60
        , DecodeUtf8.benchmark "data/russian.txt"
        , FileRead.benchmark "data/russian.txt"
        , StripBrackets.benchmark "data/russian.txt"
        , WordCount.benchmark "data/russian.txt"
        ]
