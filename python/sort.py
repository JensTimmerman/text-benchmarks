#!/usr/bin/env python

import utils, sys
import functools

def sort(string):
    lines = string.splitlines()
    lines.sort()
    return '\n'.join(lines)

for f in sys.argv[1:]:
    t = utils.benchmark(functools.partial(
                    			sys.stdout.write,
                    				utils.with_utf8_file(f,sort).encode('utf-8')
                    			)
                    	)
    sys.stderr.write('{0}: {1}\n'.format(f, t))