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


main :: IO ()
main = do
    inputSpec' <- inputSpec
    defaultMain $ toBenchmarks inputSpec'

inputSpec :: IO InputSpec
inputSpec = do
    allDataFiles' <- allDataFiles
    return
        [ (CaseMap.benchmark, allDataFiles')
        ]

allDataFiles :: IO [FilePath]
allDataFiles = do
    contents <- getDirectoryContents "data"
    return $ map ("data" </>) $ filter proper contents
  where
    proper p = not $ "." `isPrefixOf` p
