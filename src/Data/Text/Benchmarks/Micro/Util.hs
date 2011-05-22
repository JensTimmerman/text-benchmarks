-- | Utilities for the text microbenchmarks
--
module Data.Text.Benchmarks.Micro.Util
    ( withUtf8File
    ) where

import Control.Exception (evaluate)
import Data.Text (Text)
import qualified Data.ByteString as SB
import qualified Data.Text.Encoding as T

-- | Perform an operation directly on the contents of a file
--
withUtf8File :: (Text -> a) -> FilePath -> IO a
withUtf8File f p = do
    t <- T.decodeUtf8 `fmap` SB.readFile p
    r <- evaluate $ f t
    return r
