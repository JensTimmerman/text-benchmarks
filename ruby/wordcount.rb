#!/usr/bin/env ruby

require './utils.rb'

def wordcount(str)
  freqs = Hash.new 0
  str.split.each do |w|
    freqs[w.downcase] += 1
  end
  freqs
end

ARGV.each do |f|
  t = benchmark { with_utf8_file(f) { |c| wordcount(c) } }
  puts "#{f}: #{t}"
end
