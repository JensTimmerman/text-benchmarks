-- | Main module to run the micro benchmarks
--
module Main
    ( main
    ) where

import Data.List (isPrefixOf)
import System.Directory (getDirectoryContents)
import System.FilePath ((</>))

import Criterion.Main (defaultMain)

import Data.Text.Benchmarks.Micro.Types
import qualified Data.Text.Benchmarks.Micro.CaseMap as CaseMap
import qualified Data.Text.Benchmarks.Micro.FileRead as FileRead
import qualified Data.Text.Benchmarks.Micro.StripBrackets as StripBrackets
import qualified Data.Text.Benchmarks.Micro.WordCount as WordCount

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
        , (StripBrackets.benchmarks, ["data/japanese.txt"])
        , (WordCount.benchmarks, ["data/bmp.txt"])
        ]

allDataFiles :: IO [FilePath]
allDataFiles = do
    contents <- getDirectoryContents "data"
    return $ map ("data" </>) $ filter proper contents
  where
    proper p = not $ "." `isPrefixOf` p
