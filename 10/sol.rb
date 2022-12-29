# file = "sample.in"
file = "1.in"

cycle = 0
x = 1
ans = 0
def f(x, cycle)
  case cycle
  when 20, 60, 100, 140, 180, 220
    x * cycle
  else
    0
  end
end

# part 2
crt = ""
def draw(x, cycle)
 if x - 1 <= (cycle - 1)%40 && (cycle - 1)%40 <= x + 1
    "#"
 else
    "."
 end
end

File.read(file).split("\n").map{|line|
  op, val = line.split(" ")
  case op
  when "noop"
    cycle += 1
    ans += f(x, cycle)
    crt += draw(x, cycle)
  when "addx"
    cycle += 1
    ans += f(x, cycle)
    crt += draw(x, cycle)
    cycle += 1
    ans += f(x, cycle)
    crt += draw(x, cycle)
    x += val.to_i
  end
}
p ans
puts crt.chars.each_slice(40).to_a.map(&:join).reduce(""){|acc,i| acc+=i+"\n"}