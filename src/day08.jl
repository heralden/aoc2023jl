module day08

export solve1, solve2

function parse_nodes(nodes)
  Map = Dict()
  for node in nodes
    (root, left, right) = map(m -> m.match, eachmatch(r"\w+", node))
    Map[root] = (left, right)
  end
  return Map
end

function traverse(Map, path, pos, traversals)
  for dir in path
    traversals += 1
    if dir == 'L'
      pos = first(Map[pos])
    elseif dir == 'R'
      pos = last(Map[pos])
    end
  end
  if pos == "ZZZ"
    return traversals
  else
    return traverse(Map, path, pos, traversals)
  end
end

function solve1(in)
  (path, nodes...) = filter(!isempty, split(in, "\n"))
  Map = parse_nodes(nodes)
  traverse(Map, path, "AAA", 0)
end

function traverse_multiple(Map, path, poss, traversals)
  cycles = fill(0, length(poss))
  while any(==(0), cycles)
    for dir in path
      traversals += 1
      for i in eachindex(poss)
        if dir == 'L'
          poss[i] = first(Map[poss[i]])
        elseif dir == 'R'
          poss[i] = last(Map[poss[i]])
        end
        if endswith(poss[i], "Z") && cycles[i] == 0
          cycles[i] = traversals
        end
      end
    end
  end
  cycles
end

function solve2(in)
  (path, nodes...) = filter(!isempty, split(in, "\n"))
  Map = parse_nodes(nodes)
  starts = collect(filter(k -> endswith(k, "A"), keys(Map)))
  cycles = traverse_multiple(Map, path, starts, 0)
  return lcm(cycles...)
end

end
