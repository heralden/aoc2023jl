module day06

export solve1, solve2

function count_better(t, d)
  better = 0
  for spd in 1:t-1
    remt = t - spd
    dst = remt * spd
    if dst > d
      better += 1
    end
  end
  better
end

function solve1(in)
  (times, distances) = filter(!isempty, split(in, "\n"))
  (_, times...) = split(times, r"\s+")
  (_, distances...) = split(distances, r"\s+")
  times = parse.(Int, times)
  distances = parse.(Int, distances)
  counts = []
  for (t, d) in zip(times, distances)
    push!(counts, count_better(t, d))
  end
  reduce(*, counts)
end

function solve2(in)
  (times, distances) = filter(!isempty, split(in, "\n"))
  (_, times...) = split(times, r"\s+")
  (_, distances...) = split(distances, r"\s+")
  t = parse(Int, join(times))
  d = parse(Int, join(distances))
  count_better(t, d)
end

end
