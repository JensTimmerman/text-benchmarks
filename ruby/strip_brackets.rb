#!/usr/bin/env ruby

require './utils.rb'

def strip_brackets(str)
  i = d = 0
  out = ''

  while i < str.length do
    d += 1 if str[i] == '{' || str[i] == '['
    out << if d > 0 then ' ' else str[i] end
    d -= 1 if str[i] == '}' || str[i] == ']'
    i += 1
  end

  out
end

ARGV.each do |f|
  t = benchmark { with_utf8_file(f) { |c| strip_brackets(c) } }
  puts "#{f}: #{t}"
end
