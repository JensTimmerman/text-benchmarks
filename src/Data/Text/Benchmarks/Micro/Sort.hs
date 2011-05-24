-- | Implements the unix @sort@ program
--
{-# LANGUAGE OverloadedStrings #-}
module Data.Text.Benchmarks.Micro.Sort
    ( benchmark
    ) where

import Data.Monoid (mconcat)
import qualified Data.List as L
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Encoding as TL
import qualified Data.Text.Lazy.Builder as TLB
import System.IO (Handle)

import Criterion.Main (Benchmark, bench)

benchmark :: FilePath -> Handle -> Benchmark
benchmark fp sink = bench "Sort" $ do
    t <- T.decodeUtf8 `fmap` B.readFile fp
    BL.hPutStr sink $ TL.encodeUtf8 $ sort t

sort :: T.Text -> TL.Text
sort = TLB.toLazyText . mconcat . L.intersperse (TLB.fromText "\n") .
    map TLB.fromText . L.sort . T.lines
