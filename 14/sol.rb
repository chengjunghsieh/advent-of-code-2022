file = "sample.in"
# file = "1.in"

walls = Hash.new(0)
def mark_walls(walls, a, b, c, d)
  if b == d
    ([a,c].min..[a,c].max).each{|i| walls[[b,i]] = 1}
  else
    ([b,d].min..[b,d].max).each{|i| walls[[i,a]] = 1}
  end
end

File.read(file).split("\n")
  .map{|line| line.split("->")
    .map{|line| line.split(",").map(&:to_i)}
    .each_cons(2){|i, j| mark_walls(walls, *i, *j)}
  }
def solve_1(walls)
  inf = 1000
  sands = Hash.new(0)
  while true
    sand = [0, 500]
    while true
      ok = false
      [[1,0],[1,-1],[1,1]].each{|i,j|
        x, y = sand[0]+i, sand[1]+j
        if walls[[x,y]]==0 && sands[[x,y]]==0
          ok = true
          sand = [x, y]
          break
        end
      }
      if !ok || sand[0] > inf
        break
      end
    end
    if sand[0] > inf
      break
    end
    sands[sand] = 1
  end
  p sands.length
end

def solve_2(walls)
  floor = walls.keys.map{|i,j| i}.max + 1
  sands = Hash.new(0)
  while true
    sand = [0, 500]
    while true
      ok = false
      [[1,0],[1,-1],[1,1]].each{|i,j|
        x, y = sand[0]+i, sand[1]+j
        if walls[[x,y]]==0 && sands[[x,y]]==0
          ok = true
          sand = [x, y]
          break
        end
      }
      if !ok || sand[0] >= floor
        break
      end
    end
    if sand == [0, 500]
      break
    end
    # p sand
    sands[sand] = 1
  end
  p sands.length + 1  # add start point
end
solve_1(walls)
solve_2(walls)