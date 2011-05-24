require 'benchmark'

def benchmark(&b)
  runs = 100
  
  Benchmark.bmbm do |x|
    x.report { runs.times { b.call } }
  end
end

def with_utf8_file(filename)
  File.open(filename, 'r:utf-8') do |file|
    yield file.read
  end
end
