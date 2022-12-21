input = File.read("1.in")

def num_of_distinct(input, k)
  (k...input.length).each{|i|
    if input[i-k...i].split('').reduce({}) {|acc,c| acc[c]=1; acc}.length == k
      return i
    end
  }
  -1
end

p num_of_distinct(input, 4)
p num_of_distinct(input, 14)