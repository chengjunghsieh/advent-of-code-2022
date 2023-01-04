# Facing is 0 for right (>), 1 for down (v), 2 for left (<), and 3 for up (^).
# The final password is the sum of 1000 times the row, 4 times the column, and the facing.
dir = [[0, 1], [1, 0], [0, -1], [-1, 0]]
def facing_score(dir, facing)
  dir.index(facing)
end

def calc_score(row, col, dir, facing)
  row * 1000 + col * 4 + facing_score(dir, facing)
end


# 1. Read Input
# file = "sample.in"
file = "1.in"
board_input, operation = File.read(file).split("\n\n")

rows = Hash.new{|h, k| h[k] = []}
cols = Hash.new{|h, k| h[k] = []}
board_input.split("\n").each_with_index
  .map{|x, i| 
    x.split("").each_with_index.map{|y, j| [y, j]}.select{|y, j| y != " "}
      .map{|y, j|
        rows[i + 1] << [j + 1, y]
        cols[j + 1] << [i + 1, y]
      }
  }

# 2. Initial State
current_position = [1, rows[1][0][0]]
facing = [[0, 1], [1, 0], [0, -1], [-1, 0]]

def wall?(rows, cols, x, y, dir, facing)
  case facing
  when dir[0], dir[2]
    rows[x].include?([y, "#"])
  when dir[1], dir[3]
    cols[y].include?([x, "#"])
  end
end

def walk(rows, cols, x, y, dir, facing)
  case facing
  when dir[0]
    rows[x].last[0] == y ? [x, rows[x].first[0]] : [x, y + 1]
  when dir[1]
    cols[y].last[0] == x ? [cols[y].first[0], y] : [x + 1, y]
  when dir[2]
    rows[x].first[0] == y ? [x, rows[x].last[0]] : [x, y - 1]
  when dir[3]
    cols[y].first[0] == x ? [cols[y].last[0], y] : [x - 1, y]
  end
end

operation.split(/([L|R])/).each{|op|
  case op
  when "L"
    facing = facing.rotate(-1)
  when "R"
    facing = facing.rotate
  else
    val = op.to_i
    val.times{
      new_position = walk(rows, cols, *current_position, dir, facing[0])
      if wall?(rows, cols, *new_position, dir, facing[0])
        break
      end
      current_position = new_position
    }
  end
}
p calc_score(*current_position, dir, facing[0])