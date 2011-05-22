-- | Benchmarks simple file reading
--
module Data.Text.Benchmarks.Micro.FileRead
    ( benchmark
    ) where

import Control.Exception (evaluate)
import qualified Data.Text.IO as T
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.Text.Lazy.IO as LT
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Lazy.Encoding as LT
import qualified Data.ByteString as SB
import qualified Data.ByteString.Lazy as LB

import Criterion.Main (Benchmark, bgroup, bench)

benchmark :: FilePath -> Benchmark
benchmark p = bgroup "FileRead"
    [ bench "String" $ readFile p >>= evaluate . length
    , bench "ByteString" $ SB.readFile p >>= evaluate . SB.length
    , bench "LazyByteString" $ LB.readFile p >>= evaluate . LB.length
    , bench "Text" $ T.readFile p >>= evaluate . T.length
    , bench "LazyText" $ LT.readFile p >>= evaluate . LT.length
    , bench "ByteStringText" $
        SB.readFile p >>= evaluate . T.length . T.decodeUtf8
    , bench "ByteStringLazyText" $
        LB.readFile p >>= evaluate . LT.length . LT.decodeUtf8
    ]
