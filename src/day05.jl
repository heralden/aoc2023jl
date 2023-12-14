module day05

export solve1, solve2

function intersection(a::UnitRange, b::UnitRange)
  a1 = first(a); a2 = last(a)
  b1 = first(b); b2 = last(b)
  r = max(a1, b1):min(a2, b2)
  if first(r) > last(r)
    return nothing
  else
    return r
  end
end

function differences(a::UnitRange, b::UnitRange)
  in = intersection(a, b)
  if isnothing(in)
    return [a, b]
  end
  a1 = first(a); a2 = last(a)
  b1 = first(b); b2 = last(b)
  i1 = first(in); i2 = last(in)
  ra = nothing
  rb = nothing
  if min(a1, b1) < i1
    ra = min(a1, b1):i1-1
  end
  if max(a2, b2) > i2
    rb = i2+1:max(a2, b2)
  end
  return [ra, in, rb]
end

function addrange(n, r::UnitRange)
  return first(r)+n:last(r)+n
end

function map_ranges_(submaps, input_ranges)
  found_ranges = []
  ranges = [input_ranges...]
  for (dst, src, len) in submaps
    for range in ranges
      ranges = []
      diffs = differences(range, src:src+len-1)
      if length(diffs) == 3
        (diff1, in, diff2) = diffs
        !isnothing(diff1) && push!(ranges, diff1)
        !isnothing(diff2) && push!(ranges, diff2)
        push!(found_ranges, addrange(dst-src, in))
      else
        push!(ranges, range)
      end
    end
  end
  return vcat(found_ranges, ranges)
end

# I tried to do this the nice way, but implementing set operations on ranges is tricky...

function map_ranges(submaps, input_ranges)
  found_ranges = []
  while !isempty(input_ranges)
    ranges = [pop!(input_ranges)]
    for (dst, src, len) in submaps
      for range in ranges
        ranges = []
        r1 = first(range)
        r2 = last(range)
        if r1 < src && r2 < src # -[]
          push!(ranges, r1:r2)
        elseif r1 < src && src <= r2 < src+len # -[-]
          push!(ranges, r1:src-1)
          push!(found_ranges, dst:r2-src+dst)
        elseif r1 < src && r2 >= src+len # -[-]-
          push!(ranges, r1:src-1)
          push!(found_ranges, dst:dst+len-1)
          push!(ranges, src+len:r2)
        elseif src <= r1 < src+len && src <= r2 < src+len # [-]
          push!(found_ranges, r1-src+dst:r2-src+dst)
        elseif src <= r1 < src+len && r2 >= src+len # [-]-
          push!(found_ranges, r1-src+dst:dst+len-1)
          push!(ranges, src+len:r2)
        elseif r1 >= src+len && r2 >= src+len # []-
          push!(ranges, r1:r2)
        end
      end
    end
    push!(found_ranges, ranges...)
  end
  return found_ranges
end

function create_fmap(submaps)
  return (ranges) -> map_ranges(submaps, ranges)
end

function build_fmaps(rawmaps)
  maps = []
  map = []
  for line in reverse(rawmaps)
    if occursin("map", line)
      push!(maps, reverse(map))
      map = []
    else
      push!(map, parse.(Int, split(line, r"\s+")))
    end
  end
  return reduce(∘, create_fmap.(maps))
end

function parse_seeds(seeds)
  (_, seeds...) = split(seeds, r"\s+")
  return parse.(Int, seeds)
end

function solve1(in)
  (seeds, rawmaps...) = filter(!isempty, split(in, "\n"))
  seeds = parse_seeds(seeds)
  fmaps = build_fmaps(rawmaps)
  return minimum(map(first, fmaps(seeds)))
end

function range_seeds(seeds)
  ranged_seeds = []
  for (start, count) in Iterators.partition(seeds, 2)
    push!(ranged_seeds, start:start+count-1)
  end
  return ranged_seeds
end

function solve2(in)
  (seeds, rawmaps...) = filter(!isempty, split(in, "\n"))
  seeds = seeds |> parse_seeds |> range_seeds
  fmaps = build_fmaps(rawmaps)
  return first(minimum(fmaps(seeds)))
end

end
