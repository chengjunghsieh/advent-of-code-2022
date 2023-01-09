require 'matrix'

# file = "sample.in"
file = "1.in"

# ore robot <- a ore
# clay robot <- b ore
# obsidian robot <- c ore, d clay
# geode robot <- e ore, f obsidian
blueprints = File.read(file).split("\n").map{|line|
  blueprint, other = line.split(":")
  b = other.strip.split(/\./).map{|i|
    i.scan(/\d+/).map(&:to_i)
  }
  [
    Vector[b[0][0], 0, 0, 0],
    Vector[b[1][0], 0, 0, 0],
    Vector[b[2][0], b[2][1], 0, 0],
    Vector[b[3][0], 0, b[3][1], 0]
  ]
}

I = [
  Vector[1, 0, 0, 0],
  Vector[0, 1, 0, 0],
  Vector[0, 0, 1, 0],
  Vector[0, 0, 0, 1]
]

def solve(blueprint, max_time, current_max)
  max_bot = blueprint.map{|i| i.to_a}.transpose.map{|i| i.max}
  max_bot[-1] = 10000000 # random large number

  dp = ->(time, robots, minerals, dp) {
    # p [time, blueprint, robots, minerals]
    if time >= max_time
      return current_max
    end

    # Optimization 1:
    # assume we could create a bot each minute (regardless of the minerals)
    # if under such circumstances we can't exceed the current maxium than prune.
    time_remain = max_time - time
    if minerals.to_a.last + robots.to_a.last * time_remain + (time_remain - 1) * time_remain / 2 <= current_max
      return 0
    end
    current_max = [current_max, minerals.to_a.last + robots.to_a.last * time_remain].max
    blueprint.each_with_index.map{|b, i|
      # Optimization 2:
      # we don't need too much robots to produce mineral
      if robots[i] >= max_bot[i]
        next 0
      end
      time_need = b.to_a.length.times.map{|j|
        if b[j] > 0
          if robots[j] == 0
            max_time + 1
          elsif minerals[j] >= b[j]
            0
          else
            (b[j] - minerals[j] + robots[j] - 1) / robots[j]
          end
        else
          0
        end
      }.max
      if time + time_need + 1 > max_time
        0
      else
        new_robots = robots + I[i]
        new_minerals = minerals + robots * (time_need + 1) - b
        dp.(time + time_need + 1, robots + I[i], minerals + robots * (time_need + 1) - b, dp)
      end
    }.max
  }
  robots = Vector[1, 0, 0, 0] # ore, clay, obsidian, geode
  minerals = Vector[0, 0, 0, 0]
  dp.(0, robots, minerals, dp)
end

p blueprints.each_with_index.map{|v, i|
  solve(v, 24, 0) * (i + 1)
}.sum

p blueprints.take(3).map{|v|
  solve(v, 32, 0)
}.inject(:*)