#!/usr/bin/env python

import utils, sys

for f in sys.argv[1:]:
    t = utils.benchmark(lambda: utils.with_utf8_file(f, lambda c: len(c)))
    print('{0}: {1}'.format(f, t))
