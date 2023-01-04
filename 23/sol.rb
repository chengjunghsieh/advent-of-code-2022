# file = "sample.in"
# file = "sample_2.in"
file = "1.in"
input  = File.read(file).split("\n")
n, m = input.length, input[0].length

dir = [[1,0],[-1,0],[0,1],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]
rules = [
  [[-1,0], [-1, 1], [-1, -1]],  # N, NE, or NW
  [[1,0], [1, 1], [1, -1]],  # S, SE, or SW
  [[0,-1], [1, -1], [-1, -1]],  # W, NW, or SW
  [[0,1], [1, 1], [-1, 1]], # E, NE, or SE
]

positions = Hash.new(0)
n.times{|i| m.times{|j| if input[i][j]=="#"; positions[[i,j]]+=1 end}}

count_around = ->(x, y) { dir.map{|i, j| [x+i, y+j]}.filter{|i,j| positions.key?([i,j])}.length > 0 }

check = ->(rule, x, y) { count_around.(x, y) && rule.filter{|i,j| positions.key?([x+i, y+j])}.length == 0 }

move_elf = ->(i, j) { rules.map{|r| check.(r,i,j)? [i+r[0][0], j+r[0][1]] : nil}.find{|i| i!=nil} }

solve_1 = ->() {
  p "Solution 1"
  pos = positions.keys
  xs = pos.map{|i,j| i}
  ys = pos.map{|i,j| j}
  lx, rx, ly, ry = xs.min, xs.max, ys.min, ys.max
  h = (rx - lx).abs + 1
  w = (ry - ly).abs + 1
  # p [lx, rx, ly, ry, h, w, pos.length]
  p h * w - pos.length
}

round = 1050
round.times{|current_round|
  if current_round == 10
    solve_1.()
  end
  # p "Current Round #{current_round}"
  # p positions
  cnt = Hash.new(0)
  new_positions = Hash.new(0)
  positions.each{|k, v|
    i, j = k
    ni, nj = move_elf.(i, j)
    if ni != nil
      cnt[[ni, nj]] += 1
    end
  }
  ok = false
  positions.each{|k, v|
    i, j = k
    ni, nj = move_elf.(i, j)

    if ni != nil && cnt[[ni, nj]] == 1
      new_positions[[ni, nj]] += 1
      ok = true
    else
      new_positions[[i, j]] += 1
    end
  }
  if !ok
    p "Solution 2: #{current_round + 1}"
    break
  end
  if positions.length != new_positions.length
    p "Error: #{positions.length} and #{new_positions_length}"
    break
  end
  positions = new_positions
  rules = rules.rotate
}
