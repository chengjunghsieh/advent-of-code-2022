# A for Rock, B for Paper, and C for Scissors
# X for Rock, Y for Paper, and Z for Scissors
# 1 for Rock, 2 for Paper, and 3 for Scissors
# 0 if you lost, 3 if the round was a draw, and 6 if you won
def score(a)
  case a
  when "X", "A"
    1
  when "Y", "B"
    2
  when "Z", "C"
    3
  end
end

def win_score(a, b)
  if score(a) == score(b)
    return 3
  end
  if b == "X"
    return a == 'B' ? 0 : 6
  end
  if b == "Y"
    return a == 'A' ? 6 : 0
  end
  if b == "Z"
    return a == 'B' ? 6 : 0
  end
end

ans = 0
File.foreach("1.in") { |line|
  a, b = line.strip.split(' ')
  ans += win_score(a, b) + score(b)
}
p ans