-- | Types used for the text microbenchmarks
--
{-# LANGUAGE ExistentialQuantification #-}
module Data.Text.Benchmarks.Micro.Types
    ( TextBenchmark
    , textBenchmark
    , toBenchmark
    , InputSpec
    , toBenchmarks
    ) where

import Control.Applicative ((<$>), (<*>))

import Criterion.Main

-- | Type used for text benchmarks
--
data TextBenchmark = forall b. Benchmarkable b => TextBenchmark
    { -- | Descriptive name
      benchmarkName    :: String
    , -- | Actual benchmark program
      benchmarkProgram :: FilePath -> b
    }

-- | @TextBenchmark@ constructor
--
textBenchmark :: Benchmarkable b => String -> (FilePath -> b) -> TextBenchmark
textBenchmark n p = TextBenchmark {benchmarkName = n, benchmarkProgram = p}

-- | Convert a text benchmark to a criterion benchmark
--
toBenchmark :: TextBenchmark -> FilePath -> Benchmark
toBenchmark (TextBenchmark n p) f = bench (n ++ ": " ++ f) (p f)

-- | Specify benchmarks and their input files
--
type InputSpec = [([TextBenchmark], [FilePath])]

-- | Create a benchmark for every file
--
toBenchmarks :: InputSpec -> [Benchmark]
toBenchmarks = concatMap $ \(b, fs) -> toBenchmark <$> b <*> fs
