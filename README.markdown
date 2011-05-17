text-benchmarks
===============

This is a collection of tests for the
[text](http://hackage.haskell.org/package/text) Haskell library. I currently
maintain them in a separate repository, altough I am likely to merge them with
the text repo later.

Dependencies
------------

We use the source code for the `text` package. Currently, we assume the `text`
[repo](http://bitbucket.org/bos/text") is checked out in `../text`.

Overview
--------

    data                   Actual test data (not in repo)
    src                    Source files of the haskell benchmarks
    text-benchmarks.cabal  Cabal file which compiles all benchmarks
    Makefile               Has targets for common tasks
