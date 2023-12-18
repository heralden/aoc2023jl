module day10

export solve1, solve2

const legend = Dict(
  'S' => Set([:n, :s, :e, :w]),
  '|' => Set([:n, :s]),
  '-' => Set([:w, :e]),
  'L' => Set([:n, :e]),
  'J' => Set([:w, :n]),
  '7' => Set([:w, :s]),
  'F' => Set([:e, :s]),
  '.' => Set(),
)

function adjacent(tiles, i, prevdir=nothing)
  (w, h) = size(tiles)
  (x, y) = Tuple(i)
  dirs = legend[tiles[i]]
  isempty(dirs) && return []
  if !isnothing(prevdir)
    !in(prevdir, dirs) && return []
    dirs = symdiff(Set([prevdir]), dirs)
  end
  adjacents = []
  y > 1 && :n in dirs && push!(adjacents, (:s, i - CartesianIndex(0,1)))
  x > 1 && :w in dirs && push!(adjacents, (:e, i - CartesianIndex(1,0)))
  y < h && :s in dirs && push!(adjacents, (:n, i + CartesianIndex(0,1)))
  x < w && :e in dirs && push!(adjacents, (:w, i + CartesianIndex(1,0)))
  adjacents
end

function find_start(tiles)
  for i in CartesianIndices(tiles)
    if tiles[i] == 'S'
      return i
    end
  end
end

function walk(tiles, start)
  max_steps = 1
  walkers = adjacent(tiles, start)
  while !reduce(==, map(last, walkers))
    max_steps += 1
    next_walkers = []
    for (prevdir, i) in walkers
      nextdirs = adjacent(tiles, i, prevdir)
      push!(next_walkers, nextdirs...)
    end
    walkers = next_walkers
  end
  max_steps
end

function solve1(in)
  tiles = map(collect, filter(!isempty, split(in, "\n")))
  tiles = reshape(reduce(vcat, tiles), (length(tiles[1]),length(tiles)))
  start = find_start(tiles)
  walk(tiles, start)
end

end
