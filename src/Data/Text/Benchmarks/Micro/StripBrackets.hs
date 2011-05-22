-- | Program to replace everything between brackets by spaces
--
-- This program was originally contributed by Petr Prokhorenkov.
--
module Data.Text.Benchmarks.Micro.StripBrackets
    ( benchmarks
    ) where
     
import Control.Exception (evaluate)
import qualified Data.ByteString as B
import qualified Data.Text.Encoding as T
import qualified Data.Text as T

import Data.Text.Benchmarks.Micro.Types

benchmarks :: [TextBenchmark]
benchmarks = return $ textBenchmark "StripBrackets" $ \fp -> do
    t <- T.decodeUtf8 `fmap` B.readFile fp
    evaluate $ stripBrackets t

stripBrackets :: T.Text -> T.Text
stripBrackets = snd . T.mapAccumL f (0 :: Int)
  where
    f depth c =
        let depth' = depth + d' c
            c' | depth > 0 || depth' > 0 = ' '
               | otherwise = c
        in (depth', c')

    d' '{' = 1
    d' '[' = 1
    d' '}' = -1
    d' ']' = -1
    d' _   = 0
