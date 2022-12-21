# A for Rock, B for Paper, and C for Scissors
# X means you need to lose, Y means you need to end the round in a draw, and Z means you need to win
# 1 for Rock, 2 for Paper, and 3 for Scissors
# 0 if you lost, 3 if the round was a draw, and 6 if you won
def score(a)
  case a
  when "A"
    1
  when "B"
    2
  when "C"
    3
  end
end

def win_score(a)
  case a
  when "X"
    0
  when "Y"
    3
  when "Z"
    6
  end
end

def type(a, b)
  case b
  when "X"
    if a == "A"
      return "C"
    elsif a == "B"
      return "A"
    else a == "C"
      return "B"
    end
  when "Y"
    return a
  when "Z"
    if a == "A"
      return "B"
    elsif a == "B"
      return "C"
    else a == "C"
      return "A"
    end
  end
end

ans = 0
File.foreach("1.in") { |line|
  a, b = line.strip.split(' ')
  ans += win_score(b) + score(type(a, b))
}
p ans