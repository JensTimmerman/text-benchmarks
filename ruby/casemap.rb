#!/usr/bin/env ruby

def benchmark_once
  start = Time.now
  yield
  stop = Time.now
  stop - start
end

def benchmark(&b)
  runs = 100
  total = 0.0
  runs.times do
    total += benchmark_once(&b)
  end
  total / runs
end

def casemap(f)
  File.open(f, 'r:utf-8') do |file|
    file.read.upcase
  end
end

ARGV.each do |f|
  t = benchmark { casemap(f) }
  puts "#{f}: #{t}"
end
