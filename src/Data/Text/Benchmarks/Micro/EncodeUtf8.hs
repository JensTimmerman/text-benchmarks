module Data.Text.Benchmarks.Micro.EncodeUtf8
    ( benchmark
    ) where

import System.IO (Handle, hPutStr)
import qualified Data.ByteString as B
import qualified Data.ByteString.Lazy as BL
import qualified Data.Text as T
import qualified Data.Text.IO as T
import qualified Data.Text.Encoding as T
import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Encoding as TL
import qualified Data.Text.Lazy.IO as TL

import Criterion.Main (Benchmark, bgroup, bench)

benchmark :: Handle -> String -> Benchmark
benchmark sink string = bgroup "EncodeUtf8"
    [ bench "String" $ hPutStr sink $ concat $ replicate k string
    , bench "Text" $ T.hPutStr sink $ T.replicate k text
    , bench "TextLazy" $ TL.hPutStr sink $
        TL.replicate (fromIntegral k) lazyText
    , bench "TextByteString" $ B.hPutStr sink $
        T.encodeUtf8 $ T.replicate k text
    , bench "TextByteStringLazy" $ BL.hPutStr sink $
        TL.encodeUtf8 $ TL.replicate (fromIntegral k) lazyText
    ]
  where
    -- The string in different formats
    text = T.pack string
    lazyText = TL.pack string

    -- Amount
    k = 100000
