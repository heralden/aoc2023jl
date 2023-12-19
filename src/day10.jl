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

const revlegend = Dict(value => key for (key, value) in legend)

const opposelegend = Dict(
  :n => :s,
  :s => :n,
  :e => :w,
  :w => :e,
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
  ni = i - CartesianIndex(0,1)
  y > 1 && :n in dirs && :s in legend[tiles[ni]] && push!(adjacents, (:s, ni))
  wi = i - CartesianIndex(1,0)
  x > 1 && :w in dirs && :e in legend[tiles[wi]] && push!(adjacents, (:e, wi))
  si = i + CartesianIndex(0,1)
  y < h && :s in dirs && :n in legend[tiles[si]] && push!(adjacents, (:n, si))
  ei = i + CartesianIndex(1,0)
  x < w && :e in dirs && :w in legend[tiles[ei]] && push!(adjacents, (:w, ei))
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
  path = [start, map(last, walkers)...]
  tiles[start] = revlegend[Set(map(x -> opposelegend[first(x)], walkers))]
  # @show tiles[start]
  while !reduce(==, map(last, walkers))
    max_steps += 1
    next_walkers = []
    for (prevdir, i) in walkers
      nextdirs = adjacent(tiles, i, prevdir)
      push!(next_walkers, nextdirs...)
    end
    walkers = next_walkers
    push!(path, map(last, next_walkers)...)
  end
  (max_steps, path)
end

function solve1(in)
  tiles = map(collect, filter(!isempty, split(in, "\n")))
  tiles = reshape(reduce(vcat, tiles), (length(tiles[1]),length(tiles)))
  start = find_start(tiles)
  (max_steps, _) = walk(tiles, start)
  max_steps
end

function calc_area(tiles, path)
  within = false
  count = 0
  corner = nothing
  for i in CartesianIndices(tiles)
    (x, _) = Tuple(i)
    if x == 1
      # println()
      within = false
    end
    if i in path
      # print(tiles[i])
      if tiles[i] == '|'
        within = !within
      elseif tiles[i] == 'F'
        corner = 'F'
      elseif tiles[i] == 'L'
        corner = 'L'
      elseif tiles[i] == '7' && corner == 'L'
        within = !within
      elseif tiles[i] == 'J' && corner == 'F'
        within = !within
      end
    elseif within == true
      # print('I')
      # @show i
      count += 1
    else
      # print('.')
    end
  end
  count
end

function solve2(in)
  tiles = map(collect, filter(!isempty, split(in, "\n")))
  tiles = reshape(reduce(vcat, tiles), (length(tiles[1]),length(tiles)))
  start = find_start(tiles)
  (_, path) = walk(tiles, start)
  calc_area(tiles, path)
end

end
