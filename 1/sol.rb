d= 0
a = []
File.foreach("1.in") { |line|
  s = line.strip
  if s.empty?
    a << d
    d = 0
  else
    d += line.to_i
  end
}
p a.max
p a.sort_by {|x| x}.reverse[...3].sum