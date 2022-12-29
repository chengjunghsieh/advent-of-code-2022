# file = "sample.in"
file = "1.in"
input = File.read(file).split("\n")

def get_index(input, target)
  r = input.detect{|i| i.include?(target)}
  return input.index(r), r.index(target)
end

def get_next(c)
  c == 'z' ? c : c.next
end

sx, sy = get_index(input, 'S')
ex, ey = get_index(input, 'E')
input[sx][sy] = 'a'
input[ex][ey] = 'z'

n, m = input.length, input[0].length
vis = Array.new(n * m, -1)
que = []
n.times{|i| m.times{|j|
  if input[i][j] == 'a'
    vis[i * m + j] = 0
    que << i * m + j
  end
}}
que.each{|i|
  x, y = i / m, i % m
  if x + 1 < n && vis[(x + 1) * m + y] == -1 && get_next(input[x][y]) >= input[x+1][y]
    vis[(x + 1) * m + y] = vis[i] + 1
    que << (x + 1) * m + y
  end
  if x - 1 >= 0 && vis[(x - 1) * m + y] == -1 && get_next(input[x][y]) >= input[x-1][y]
    vis[(x - 1) * m + y] = vis[i] + 1
    que << (x - 1) * m + y
  end
  if y + 1 < m && vis[x * m + y + 1] == -1 && get_next(input[x][y]) >= input[x][y+1]
    vis[x * m + y + 1] = vis[i] + 1
    que << x * m + y + 1
  end
  if y - 1 >= 0 && vis[x * m + y - 1] == -1 && get_next(input[x][y]) >= input[x][y-1]
    vis[x * m + y - 1] = vis[i] + 1
    que << x * m + y - 1
  end
}
p vis[ex * m + ey]