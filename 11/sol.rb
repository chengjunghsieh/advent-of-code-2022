file = "sample.in"
# file = "1.in"

input = File.read(file).split("\n\n").map{|line|
  s = line.split("\n")
  id = s[0].scan(/\d+/)[0].to_i
  vals = s[1].scan(/\d+/).map(&:to_i)
  eq = s[2].split(":")[1].strip
  div = s[3].scan(/\d+/)[0].to_i
  succ = s[4].scan(/\d+/)[0].to_i
  failure = s[5].scan(/\d+/)[0].to_i
  [id, vals, eq, div, succ, failure]
}

def solve_1(input)
  round = 20
  count = Array.new(input.length.to_i, 0)
  round.times{
    input.each{|arr|
      count[arr[0]] += arr[1].length.to_i
      a, _, b, op, c = arr[2].split(" ")
      arr[1].each{|i|
        a = (b == "old" ? i : b.to_i).send(op, (c == "old" ? i : c.to_i))
        a /= 3
        if a % arr[3] == 0
          input[arr[4]][1] << a
        else
          input[arr[5]][1] << a
        end
      }
      arr[1] = []
    }
  }
  count.max(2).reduce(&:*)
end
def solve_2(input)
  round = 10000
  count = Array.new(input.length.to_i, 0)
  mod = input.transpose[3].reduce(&:*)
  round.times{
    input.each{|arr|
      count[arr[0]] += arr[1].length.to_i
      a, _, b, op, c = arr[2].split(" ")
      arr[1].each{|i|
        a = (b == "old" ? i : b.to_i).send(op, (c == "old" ? i : c.to_i))
        a %= mod
        if a % arr[3] == 0
          input[arr[4]][1] << a
        else
          input[arr[5]][1] << a
        end
      }
      arr[1] = []
    }
  }
  count.max(2).reduce(&:*)
end
# p solve_1 input
p solve_2 input
