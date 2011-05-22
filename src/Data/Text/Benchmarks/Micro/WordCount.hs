-- | A word frequence count program
--
module Data.Text.Benchmarks.Micro.WordCount
    ( benchmark
    ) where
     
import Control.Exception (evaluate)
import qualified Data.Text as T
import Data.Map (Map)
import qualified Data.Map as M
import Data.List (foldl')

import Criterion.Main (Benchmark, bench)

import Data.Text.Benchmarks.Micro.Util

benchmark :: FilePath -> Benchmark
benchmark = bench "WordCount" . withUtf8File (M.size . wordCount)

wordCount :: T.Text -> Map T.Text Int
wordCount =
    foldl' (\m k -> M.insertWith (+) k 1 m) M.empty . map T.toLower . T.words
