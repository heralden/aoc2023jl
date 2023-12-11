module day02

export solve1, solve2

function read_set(s)
  cubes = map(split(s, ",")) do sub
    count = parse(Int, match(r"\d+", sub).match)
    color = match(r"[a-z]+", sub).match
    return (color, count)
  end
  return Dict(cubes)
end

const expected = Dict(
  "red"=>12,
  "green"=>13,
  "blue"=>14,
)

function score_set(received)
  valid = true
  min_set = Dict("red"=>0, "green"=>0, "blue"=>0)
  for set in received
    for (color, count) in set
      if count > get(expected, color, 0)
        valid = false
      end
      if count > get(min_set, color, 0)
        min_set[color] = count
      end
    end
  end
  power = reduce(*, values(min_set))
  return (valid, power)
end

function play_game(s, method)
  (game, sets...) = split(s, r"[:;]")
  id = parse(Int, match(r"\d+", game).match)
  sets = map(read_set, sets)
  (valid, power) = score_set(sets)

  if method == "id"
    return valid ? id : 0
  elseif method == "power"
    return power
  end
end

function solve1(in)
  sum = 0
  for s in split(in, "\n")
    if !isempty(s)
      sum += play_game(s, "id")
    end
  end
  return sum
end

function solve2(in)
  sum = 0
  for s in split(in, "\n")
    if !isempty(s)
      sum += play_game(s, "power")
    end
  end
  return sum
end

end
