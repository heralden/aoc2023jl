module day04

export solve1, solve2

function matches_card(card)
  (_, winning, got) = strip.(split(card, r"[:|]"))
  (wins, gots) = map.(x -> parse(Int, x), split.([winning, got], r"\s+"))
  matches = intersect(wins, gots)
  return length(matches)
end

function solve1(in)
  cards = filter(!isempty, split(in, "\n"))
  return sum(map(n -> n == 0 ? 0 : 1 << (n-1), matches_card.(cards)))
end

function solve2(in)
  cards = filter(!isempty, split(in, "\n"))
  total_cards = 0
  copies = []
  for matches in matches_card.(cards)
    # println("$matches $copies $total_cards")
    count = 1
    if !isempty(copies)
      count += popfirst!(copies)
    end
    total_cards += count
    for i = 1:matches
      if length(copies) < i
        push!(copies, count)
      else
        copies[i] += count
      end
    end
  end
  return total_cards
end

end
