#!/usr/bin/env python

import sys, time

def benchmark_once(f):
    start = time.time()
    f()
    end = time.time()
    return end - start

def benchmark(f):
    runs = 100
    total = 0.0
    for i in range(runs):
        total += benchmark_once(f)
    return total / runs

def casemap(f):
    s = open(f).read().decode('utf-8')
    s.upper()

for f in sys.argv[1:]:
    t = benchmark(lambda: casemap(f))
    print('{0}: {1}'.format(f, t))
