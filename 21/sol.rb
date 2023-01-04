# file = "sample.in"
file = "1.in"

graph = Hash.new{|h, k| h[k] = Array.new {|a| a = []}}
memo = {}
memo2 = {}
File.read(file).split("\n").each{|line|
  case line
  when /(\w+): (\d+)/
    var, val = $1, $2
    memo[var] = val.to_i
    memo2[var] = [0, val.to_i]
  when /(\w+):\s+(\S+)\s+(\S+)\s+(\S+)/
    var1, var2, op, var3 = $1, $2, $3, $4
    graph[var1] += [var2, var3, op]
  end
}
def go(graph, memo, u)
  if memo[u]
    return memo[u]
  end
  v, w, op = graph[u]
  memo[u] = go(graph, memo, v).send(op, go(graph, memo, w))
end
root = "root"
p go(graph, memo, root)


def go1(graph, memo, u)
  if u == "humn"
    return [1, 0]
  end
  if memo[u]
    return memo[u]
  end
  v, w, op = graph[u]
  a, b = go1(graph, memo, v)
  c, d = go1(graph, memo, w)
  memo[u] =
    case op
    when "+"
      [a + c, b + d]
    when "-"
      [a - c, b - d]
    when "*"
      [a * d + b * c, b * d]
    when "/"
      [a * 1.0 / d, b * 1.0 / d]
    end
end
var1, var2 = graph[root][0], graph[root][1]
a, b = go1(graph, memo2, var1)
c, d = go1(graph, memo2, var2)
if a == c
  p "Inf"
else
  p (d - b) / (a - c)
end