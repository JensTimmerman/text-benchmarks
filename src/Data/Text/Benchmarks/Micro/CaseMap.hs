-- | This benchmark converts a number of UTF-8 encoded files to uppercase.
-- It takes the list of files on stdin, one filename on each line. It then uses
-- the criterion library to run a the benchmark on each file & get reliable
-- results.
--
module Data.Text.Benchmarks.Micro.CaseMap
    ( benchmark
    ) where
     
import qualified Data.Text as T
import Criterion.Main (Benchmark, bench)

import Data.Text.Benchmarks.Micro.Util

benchmark :: FilePath -> Benchmark
benchmark = bench "CaseMap" . withUtf8File T.toUpper
