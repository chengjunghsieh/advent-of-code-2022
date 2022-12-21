w = ("a".."z").to_a + ("A".."Z").to_a
p File.read("1.in").split.map{|line|
  line.strip.chars.each_slice(line.strip.length / 2).map(&:uniq)
      .inject(w) {|acc, s| acc & s}
      .map{|a| w.index(a) + 1}.sum
}.sum