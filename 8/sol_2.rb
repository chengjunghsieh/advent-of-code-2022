# file =  "sample.in"
file =  "1.in"
a = File.read(file).split("\n").map{|i| i.split("")}.map{|i| i.map(&:to_i)}
n = a.length
m = a[0].length
(0...n).each {|i|
  (0...m).each{|j|
    if i == 0 || i + 1 == n || j == 0 || j + 1 == m
      a[i][j] = 9
    end
  }
}
ta = a.transpose
ans = (0...n*m).map{|i|
  j,k = i/m, i%m
  if j == 0 || j + 1 == n || k == 0 || k + 1 == m
    next 0
  end
  x = a[j][k]
  l = a[j].each_with_index.reject{|v, i| i >= k}.select{|v, i| v >= x}.last.last
  r = a[j].each_with_index.reject{|v, i| i <= k}.select{|v, i| v >= x}.first.last
  u = ta[k].each_with_index.reject{|v, i| i >= j}.select{|v, i| v >= x}.last.last
  d = ta[k].each_with_index.reject{|v, i| i <= j}.select{|v, i| v >= x}.first.last
  (k - l) * (r - k) * (j- u) * (d - j)
}.max
p ans