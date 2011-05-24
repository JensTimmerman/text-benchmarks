require 'benchmark'

def benchmark(&block)
  runs = 100
  total = 0

  runs.times do 
    total += Benchmark.measure(&block) 
  end

  total / runs 
end

def with_utf8_file(filename)
  File.open(filename, 'r:utf-8') do |file|
    yield file.read
  end
end
