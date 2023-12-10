module day01

export solve1, solve2

function solve1(in)
  values = []
  for s in split(in, "\n")
    digits = map(m -> parse(Int, m.match), eachmatch(r"\d", s))
    if !isempty(digits)
      val = 10(first(digits)) + last(digits)
      push!(values, val)
    end
  end
  return sum(values)
end

const numbers = Dict([
  ("1", 1),
  ("2", 2),
  ("3", 3),
  ("4", 4),
  ("5", 5),
  ("6", 6),
  ("7", 7),
  ("8", 8),
  ("9", 9),
  ("one", 1),
  ("two", 2),
  ("three", 3),
  ("four", 4),
  ("five", 5),
  ("six", 6),
  ("seven", 7),
  ("eight", 8),
  ("nine", 9),
])

function startswith(sub, s)
  if length(s) < length(sub)
    return false
  end
  subs = s[1:length(sub)]
  return sub == subs
end

# Regex is no longer an option as it would only match "two" in "twone"
function solve2(in)
  values = []

  for s in split(in, "\n")
    digits = []

    for i = 1:length(s)
      substring = s[i:end]
      for sub in keys(numbers)
        if startswith(sub, substring)
          push!(digits, get(numbers, sub, -1))
          break
        end
      end
    end

    if !isempty(digits)
      val = 10(first(digits)) + last(digits)
      push!(values, val)
    end
  end

  return sum(values)
end

end
