-- | A word frequence count program
--
module Data.Text.Benchmarks.Programs.WordCount
    ( benchmarks
    ) where
     
import Control.Exception (evaluate)
import qualified Data.ByteString as B
import qualified Data.Text.Encoding as T
import qualified Data.Text as T
import Data.Map (Map)
import qualified Data.Map as M
import Data.List (foldl')

import Data.Text.Benchmarks.Types

benchmarks :: [TextBenchmark]
benchmarks = return $ textBenchmark "WordCount" $ \fp -> do
    t <- T.decodeUtf8 `fmap` B.readFile fp
    evaluate $ wordCount t

wordCount :: T.Text -> Map T.Text Int
wordCount =
    foldl' (\m k -> M.insertWith (+) k 1 m) M.empty . map T.toLower . T.words
