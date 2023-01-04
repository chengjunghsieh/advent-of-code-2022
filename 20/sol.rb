# file = "sample.in"
file = "1.in"

input = File.read(file).split("\n").map(&:to_i)

def mixing(input, array, multiplier)
  n = input.length
  mod = n - 1
  input.each_with_index{|v,i|
    d = v * multiplier % mod
    if d < 0
      d += mod
    end
    j = array.index([v,i])
    array.delete_at(j)
    array.insert((j + d) % mod, [v, i])
  }
end

def answer(input, array, multiplier)
  n = input.length
  zi = input.index(0)
  zj = array.index([0, zi])
  (array[(zj + 1000) % n][0] + array[(zj + 2000) % n][0] + array[(zj + 3000) % n][0]) * multiplier
end

def solve_1(input)
  array = input.clone.each_with_index.map{|v,i| [v,i]}
  mixing(input, array, 1)
  answer(input, array, 1)
end

def solve_2(input)
  array = input.clone.each_with_index.map{|v,i| [v,i]}
  10.times{ mixing(input, array, 811589153) }
  answer(input, array, 811589153)
end

p solve_1(input)
p solve_2(input)
