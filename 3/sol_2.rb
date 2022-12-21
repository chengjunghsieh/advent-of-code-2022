w = ("a".."z").to_a + ("A".."Z").to_a
p File.read("1.in").split.each_slice(3).to_a
      .map{|arr|
        arr.map{|s| s.split('').uniq}
         .inject(w) {|acc, a| acc & a}
         .map{|a| w.index(a) + 1}.sum
      }.sum
