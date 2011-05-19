-- | Main module to run the benchmarks
--
module Main
    ( main
    ) where

import Data.List (isPrefixOf)
import System.Directory (getDirectoryContents)
import System.FilePath ((</>))

import Criterion.Main (defaultMain)

import Data.Text.Benchmarks.Types
import qualified Data.Text.Benchmarks.Programs.CaseMap as CaseMap
import qualified Data.Text.Benchmarks.Programs.FileRead as FileRead
import qualified Data.Text.Benchmarks.Programs.StripBrackets as StripBrackets
import qualified Data.Text.Benchmarks.Programs.WordCount as WordCount

main :: IO ()
main = do
    inputSpec' <- inputSpec
    defaultMain $ toBenchmarks inputSpec'

inputSpec :: IO InputSpec
inputSpec = do
    allDataFiles' <- allDataFiles
    return
        [ (CaseMap.benchmarks, ["data/bmp.txt"])
        , (FileRead.benchmarks, ["data/bmp.txt"])
        , (StripBrackets.benchmarks, ["data/bmp.txt"])
        , (WordCount.benchmarks, ["data/bmp.txt"])
        ]

allDataFiles :: IO [FilePath]
allDataFiles = do
    contents <- getDirectoryContents "data"
    return $ map ("data" </>) $ filter proper contents
  where
    proper p = not $ "." `isPrefixOf` p
