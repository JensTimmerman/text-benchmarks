-- | Benchmarks simple file reading
--
module Data.Text.Benchmarks.Micro.FileRead
    ( benchmarks
    ) where

import Control.Monad ((>=>))
import Control.Exception (evaluate)
import qualified Data.Text.IO as T
import qualified Data.Text as T
import qualified Data.Text.Encoding as T
import qualified Data.Text.Lazy.IO as LT
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Lazy.Encoding as LT
import qualified Data.ByteString as SB
import qualified Data.ByteString.Lazy as LB

import Data.Text.Benchmarks.Micro.Types

benchmarks :: [TextBenchmark]
benchmarks =
    [ textBenchmark "FileRead/String" $ readFile >=> evaluate . length
    , textBenchmark "FileRead/ByteString" $ SB.readFile >=> evaluate . SB.length
    , textBenchmark "FileRead/LazyByteString" $
        LB.readFile >=> evaluate . LB.length
    , textBenchmark "FileRead/Text" $ T.readFile >=> evaluate . T.length
    , textBenchmark "FileRead/LazyText" $ LT.readFile >=> evaluate . LT.length
    , textBenchmark "FileRead/ByteStringText" $
        SB.readFile >=> evaluate . T.length . T.decodeUtf8
    , textBenchmark "FileRead/ByteStringLazyText" $
        LB.readFile >=> evaluate . LT.length . LT.decodeUtf8
    ]
