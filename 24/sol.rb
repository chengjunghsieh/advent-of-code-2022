# file = "sample.in"
file = "1.in"
input = File.read(file).split("\n").map(&:chars)
n, m = input.length, input[0].length
h, w = n - 2, m - 2
sx, sy = 0, 1
tx, ty = n - 1, m - 2
move_blizzard = ->(i, j, step) {
  case input[i][j]
  when ">"
    nj = j + (step % w)
    if nj > w
      nj -= w
    end
    return [i, nj]
  when "<"
    nj = j - (step % w)
    if nj <= 0
      nj += w
    end
    return [i, nj]
  when "^"
    ni = i - (step % h)
    if ni <= 0
      ni += h
    end
    return [ni, j]
  when "v"
    ni = i + (step % h)
    if ni > h
      ni -= h
    end
    return [ni, j]
  end
}

is_blizzard = ->(step) {
  board = Array.new(n) {|a| a = Array.new(m, 0)}
  (1..h).each{|i|
    (1..w).each{|j|
      case input[i][j]
      when ">", "<", "^", "v"
        ni, nj = move_blizzard.(i, j, step)
        board[ni][nj] += 1
      end
    }
  }
  board
}

push_state = ->(q, c, d, sx, sy, tx, ty, board) {
  if c == sx && d == sy
    q << [c, d]
    return
  end
  if c == tx && d == ty
    q << [c, d]
    return
  end
  if c > h || c <= 0 || d > w || d <= 0
    return
  end
  if board[c][d] > 0
    return
  end
  q << [c, d]
}

solve = ->(sx, sy, tx, ty, step) {
  q = [[sx, sy]]
  while true
    nq = []
    step += 1
    board = is_blizzard.(step)
    q.each{|x, y|
      push_state.(nq, x, y, sx, sy, tx, ty, board)
      push_state.(nq, x + 1, y, sx, sy, tx, ty, board)
      push_state.(nq, x - 1, y, sx, sy, tx, ty, board)
      push_state.(nq, x, y + 1, sx, sy, tx, ty, board)
      push_state.(nq, x, y - 1, sx, sy, tx, ty, board)
    }
    q = nq.uniq
    if q.include?([tx, ty])
      break
    end
  end
  step
}

t1 = solve.(sx, sy, tx, ty, 0)
p t1
t2 = solve.(tx, ty, sx, sy, t1)
p t2
t3 = solve.(sx, sy, tx, ty, t2)
p t3