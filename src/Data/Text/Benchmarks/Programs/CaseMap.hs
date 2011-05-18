-- | This benchmark converts a number of UTF-8 encoded files to uppercase.
-- It takes the list of files on stdin, one filename on each line. It then uses
-- the criterion library to run a the benchmark on each file & get reliable
-- results.
--
module Data.Text.Benchmarks.Programs.CaseMap
    ( benchmarks
    ) where
     
import Control.Exception (evaluate)
import qualified Data.ByteString as B
import qualified Data.Text.Encoding as T
import qualified Data.Text as T

import Data.Text.Benchmarks.Types

benchmarks :: [TextBenchmark]
benchmarks = [textBenchmark "CaseMap" caseMap]

caseMap :: FilePath -> IO T.Text
caseMap file = do
    t <- T.decodeUtf8 `fmap` B.readFile file
    evaluate $ T.toUpper t
