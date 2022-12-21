# `2-4,6-8`
def contain?(a, b, c, d)
  a <= c && d <= b
end

p File.read("1.in").split.map{|line|
  a, b, c, d = line.split(',').map{|s| s.split('-')}.flatten.map(&:to_i)
  contain?(a, b, c, d) || contain?(c, d, a, b) ? 1 : 0
}.sum
