# Checks out the datafiles needed for the tests
data:
	@echo "Downloading test data..."
	@wget http://projects.haskell.org/text/text-testdata.tar.bz2
	@echo "Extracting..."
	@tar -xjf text-testdata.tar.bz2
	@echo "Cleaning up..."
	@mv text/test data
	@rm -r text
	@rm -r text-testdata.tar.bz2
