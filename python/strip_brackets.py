#!/usr/bin/env python

import utils, sys

def strip_brackets(string):
    i = d = 0
    out = ''
    while i < len(string):
        if string[i] == '{' or string[i] == '[':
            d += 1

        if d > 0:
            out += ' '
        else:
            out += string[i]

        if string[i] == '}' or string[i] == ']':
            d -= 1

        i += 1

    return out

for f in sys.argv[1:]:
    t = utils.benchmark(lambda: utils.with_utf8_file(f, strip_brackets))
    print('{0}: {1}'.format(f, t))
