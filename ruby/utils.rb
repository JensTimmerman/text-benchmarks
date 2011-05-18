def benchmark_once
  start = Time.now
  yield
  stop = Time.now
  stop - start
end

def benchmark(&b)
  runs = 100
  total = 0.0
  runs.times do |i|
    result = benchmark_once(&b)
    puts "Run #{i}: #{result}"
    total += result
  end
  total / runs
end

def with_utf8_file(filename)
  File.open(filename, 'r:utf-8') do |file|
    yield file.read
  end
end
