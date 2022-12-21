# `2-4,6-8`
def overlap?(a, b, c, d)
  c <= b && a <= d
end

p File.read("1.in").split.select{|line|
  a, b, c, d = line.split(',').map{|s| s.split('-')}.flatten.map(&:to_i)
  overlap?(a, b, c, d) || overlap?(c, d, a, b)
}.length
