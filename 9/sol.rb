# input_file = "sample.in"
input_file = "1.in"

Point = Struct.new(:x, :y)

head = Point.new(0, 0)
tail = Point.new(0, 0)
vis = Hash.new{|h, k| h[k]=0}
IO.foreach(input_file) {|line|
  op, v = line.split
  v = v.to_i
  v.times {
    case op
    when "L"
      head.x -= 1
    when "R"
      head.x += 1
    when "U"
      head.y -= 1
    when "D"
      head.y += 1
    end
    dx = head.x - tail.x
    dy = head.y - tail.y
    if dx.abs > 1
      tail.x += 1 * (dx > 0 ? 1 : -1)
      tail.y += dy == 0 ? 0 : dy > 0 ? 1 : -1
    end
    if dy.abs > 1
      tail.x += dx == 0 ? 0 : dx > 0 ? 1 : -1
      tail.y += 1 * (dy > 0 ? 1 : -1)
    end
    vis[tail.to_h] += 1
  }
}
p vis.length