-- | Testing the internal builder monoid
--
{-# LANGUAGE OverloadedStrings #-}
module Data.Text.Benchmarks.Micro.Builder
    ( benchmark
    ) where

import qualified Data.Text as T
import qualified Data.Text.Lazy as LT
import qualified Data.Text.Lazy.Builder as LTB
import qualified Data.ByteString as SB
import qualified Data.ByteString.Lazy as LB
import Data.Binary.Builder as B
import qualified Blaze.ByteString.Builder as Blaze
import qualified Blaze.ByteString.Builder.Char.Utf8 as Blaze

import Data.Monoid (mconcat)

import Criterion.Main (Benchmark, bgroup, bench, nf)

benchmark :: Benchmark
benchmark = bgroup "Builder"
    [ bench "LazyText" $ nf
        (LT.length . LTB.toLazyText . mconcat . map LTB.fromText) texts
    , bench "Binary" $ nf
        (LB.length . B.toLazyByteString . mconcat . map B.fromByteString)
        byteStrings
    , bench "Blaze" $ nf
        (LB.length . Blaze.toLazyByteString . mconcat . map Blaze.fromString)
        strings
    ]

texts :: [T.Text]
texts = take 200000 $ cycle ["foo", "λx", "由の"]
{-# NOINLINE texts #-}

-- Note that the non-ascii characters will be chopped
byteStrings :: [SB.ByteString]
byteStrings = take 200000 $ cycle ["foo", "λx", "由の"]
{-# NOINLINE byteStrings #-}

-- Note that the non-ascii characters will be chopped
strings :: [String]
strings = take 200000 $ cycle ["foo", "λx", "由の"]
{-# NOINLINE strings #-}
