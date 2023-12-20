module day11

export solve1, solve2

function distance(a, b, expanded_cols, expanded_rows, expansion=2)
  # @show expanded_cols, expanded_rows
  (a, b) = sort([a, b])
  # @show a, b
  (x1, x2) = sort(first.(Tuple.([a, b])))
  (y1, y2) = sort(last.(Tuple.([a, b])))
  passes = 0
  for exp in expanded_cols
    if x1 < exp < x2
      passes += expansion-1
    end
  end
  for exp in expanded_rows
    if y1 < exp < y2
      passes += expansion-1
    end
  end
  # @show passes
  dist = sum(map(abs, Tuple(b-a)))
  # @show dist
  dist + passes
end

function parse_space(in)
  space = map(collect, filter(!isempty, split(in, "\n")))
  space = reshape(reduce(vcat, space), (length(space[1]),length(space)))
  galaxies = []
  for i in CartesianIndices(space)
    if space[i] == '#'
      push!(galaxies, i)
    end
  end
  galaxies
end

function pairwise(galaxies)
  pairs = []
  for i = 1:length(galaxies)
    for j = i+1:length(galaxies)
      push!(pairs, (galaxies[i], galaxies[j]))
    end
  end
  pairs
end

function expansion(galaxies)
  xs = Set(map(first∘Tuple, galaxies))
  ys = Set(map(last∘Tuple, galaxies))
  expanded_cols = []
  expanded_rows = []
  for x = minimum(xs):maximum(xs)
    if !in(x, xs)
      push!(expanded_cols, x)
    end
  end
  for y = minimum(ys):maximum(ys)
    if !in(y, ys)
      push!(expanded_rows, y)
    end
  end
  # @show expanded_cols
  # @show expanded_rows
  (expanded_cols, expanded_rows)
end

function solve1(in)
  galaxies = parse_space(in)
  pairs = pairwise(galaxies)
  (expanded_cols, expanded_rows) = expansion(galaxies)
  dists = map((pair) -> distance(first(pair), last(pair), expanded_cols, expanded_rows), pairs)
  # @show dists
  sum(dists)
end

function solve2(in)
  galaxies = parse_space(in)
  pairs = pairwise(galaxies)
  (expanded_cols, expanded_rows) = expansion(galaxies)
  dists = map((pair) -> distance(first(pair), last(pair), expanded_cols, expanded_rows, 1000000), pairs)
  # @show dists
  sum(dists)
end

end
