#!/usr/bin/env ruby

require 'csv'

hash = Hash.new { |h, k| h[k] = [] }

CSV.parse(ARGF, col_sep: "\t").each do |hanzi, pinyin, *rest|
  if pinyin && hanzi.length == 1
    hash[pinyin] << hanzi
  end
end

CSV.open('output.csv', 'w') do |out|
  hash.sort_by { |pinyin, _| pinyin }.each do |pinyin, hanzi|
    out << [pinyin, hanzi.join(' ')]
  end
end

chars = hash.inject(0) { |total, (_, hanzi)| total += hanzi.length }
puts "Total number of characters: #{chars}"
