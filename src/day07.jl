module day07

export solve1, solve2

card_types = Dict('A'=>13, 'K'=>12, 'Q'=>11, 'J'=>10, 'T'=>9, '9'=>8, '8'=>7, '7'=>6, '6'=>5, '5'=>4, '4'=>3, '3'=>2, '2'=>1)

function group(hand)
  dict = Dict()
  for card in hand
    dict[card] = get(dict, card, 0) + 1
  end
  dict
end

five_kind(hand) = hand |> group |> length == 1
four_kind(hand) = hand |> group |> values |> collect |> sort == [1, 4]
full_house(hand) = hand |> group |> values |> collect |> sort == [2, 3]
three_kind(hand) = hand |> group |> values |> collect |> sort == [1, 1, 3]
two_pair(hand) = hand |> group |> values |> collect |> sort == [1, 2, 2]
one_pair(hand) = hand |> group |> values |> collect |> sort == [1, 1, 1, 2]
high_card(hand) = hand |> group |> length == 5

function compare_hands(h1, h2)
  type1 = h1 .|> [five_kind, four_kind, full_house, three_kind, two_pair, one_pair, high_card]
  type2 = h2 .|> [five_kind, four_kind, full_house, three_kind, two_pair, one_pair, high_card]
  t1 = evalpoly(2, reverse(type1))
  t2 = evalpoly(2, reverse(type2))
  if t1 != t2
    return t1 < t2
  end
  for i in 1:length(h1)
    v1 = card_types[h1[i]]
    v2 = card_types[h2[i]]
    if v1 !== v2
      return v1 < v2
    end
  end
  @show h1 h2
  error("Identical: $h1 $h2")
end

function solve1(in)
  hands = map(l -> split(l, r"\s+"), filter(!isempty, split(in, "\n")))
  sort!(hands; lt=compare_hands, by=first)
  total = 0
  for i in eachindex(hands)
    (_, bid) = hands[i]
    total += parse(Int, bid) * i
  end
  total
end

end
