require 'benchmark'

def benchmark(&b)
  runs = 100
  
  total = Benchmark.measure { runs.times { b.call } }
  mean = total / runs
  $stderr.puts "mean: #{mean}"
end

def with_utf8_file(filename)
  File.open(filename, 'r:utf-8') do |file|
    yield file.read
  end
end
