require 'benchmark'

def benchmark
  runs = 100
  total = 0

  runs.times do 
    # Proc.new will be equal to the block given to the function
    # I just use this because it's a neat hack 
    # (also, it's 6 times faster than &block)
    total += Benchmark.measure(Proc.new) 
  end

  total / runs 
end

def with_utf8_file(filename)
  File.open(filename, 'r:utf-8') do |file|
    yield file.read
  end
end
