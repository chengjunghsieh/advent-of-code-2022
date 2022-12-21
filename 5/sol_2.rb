g, input = File.read("1.in").split(/\n\n/)
stacks = g.split("\n")[...-1]
          .map{|line|
            line.split('').each_slice(4).to_a.map{|a| a[1]}
          }.transpose
          .map{|a| a.select{|x| x != " "}.reverse}

input.split("\n").each{|line|
  num, from, to = (line.scan /\d+/).map(&:to_i)
  stacks[to-1].concat(stacks[from-1].pop(num))
  # p stacks
}
p stacks.map{|s| s.pop}.join