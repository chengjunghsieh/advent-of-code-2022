input = File.read("1.in").split("\n")
children = Hash.new{|h, k| h[k] = []}
sizes = Hash.new{|h, k| h[k] = 0}
path = [""]

input.each{|line|
  case line
  when /\$ cd (\S+)/
    x = $1
    case x
    when ".."
      path.pop
      # sizes[path.last] += sizes[me]
    else
      path.push(path.last+"/"+x)
    end
  when /\$ ls/
    # p ["ls"]
    ;
  when /^dir (\S+)/
    # p ["dir", $1]
    children[path.last].push(path.last+"/"+$1)
  when /^(\d+) \S+/
    # p ["size", $1]
    sizes[path.last] += $1.to_i
  end
}
def go(u, children, sizes)
  children[u].each{|v| go(v, children, sizes); sizes[u]+=sizes[v]}
  sizes[u]
end
go("//", children, sizes)
p sizes.select{|k, v| v <= 100000}
       .map{|k, v| v}
       .sum

total = 70000000
need = 30000000
remain = total - sizes["//"]
if remain < need
  e = need - remain
  p sizes.map{|k,v| v}.select{|v| v >= e}.sort[0]
end