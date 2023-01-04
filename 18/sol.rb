# file = "sample2.in"
file = "1.in"

input = File.read(file).split("\n").map{|i| i.split(",").map(&:to_i)}
points = input.reduce(Hash.new(0)){|acc, i| acc[i] = 1; acc}
dir = [[1,0,0], [-1,0,0], [0,1,0], [0,-1, 0], [0, 0, 1], [0, 0, -1]]
total = input.length * 6

def solve_1(input, points, dir, total)
  input.each{|a,b,c| dir.each{|i,j,k| total -= points[[a+i,b+j,c+k]]}}
  p total
end

def solve_2(input, points, dir)
  xs = input.map{|i,j,k| i}
  ys = input.map{|i,j,k| j}
  zs = input.map{|i,j,k| k}
  x_min, x_max, y_min, y_max, z_min, z_max = xs.min - 1, xs.max + 1, ys.min - 1, ys.max + 1, zs.min - 1, zs.max + 1
  vis = Hash.new(0)
  que = [[x_min, y_min, z_min]]
  vis[[x_min, y_min, z_min]] = 1
  ans = 0
  que.each {|a,b,c|
    dir.map{|i, j, k| [a+i, b+j, c+k]}
      .select{|i,j,k| vis[[i,j,k]]==0 && i>=x_min && i<=x_max && j>=y_min && j<=y_max && k>=z_min && k<=z_max}
      .each{|i,j,k|
        if points[[i,j,k]] >0
          ans += 1
        else
          vis[[i,j,k]] = 1
          que << [i,j,k]
        end
      }
  }
  p ans
end

solve_1(input, points, dir, total)
solve_2(input, points, dir)
