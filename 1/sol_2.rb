arr = File.read("1.in").split(/\n\n/).map{|i| i.split.map(&:to_i).sum}
p arr.max
p arr.sort_by{|x| x}.reverse[...3].sum
