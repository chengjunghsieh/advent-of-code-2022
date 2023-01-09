# file =  "sample.in"
file =  "1.in"
a = File.read(file).split("\n").map{|i| i.split("")}.map{|i| i.map(&:to_i)}
n = a.length
m = a[0].length
ta = a.transpose
ans = 0
(0...n*m).each{|i|
  j = i/m
  k = i%m
  x = a[j][k]
  l = a[j][...k].max
  r = a[j][k+1..].max  
  u = ta[k][...j].max
  d = ta[k][j+1..].max
  if l == nil || r == nil || u == nil || d == nil || [l, r, u, d].min < x
    ans += 1
  end
}
p ans