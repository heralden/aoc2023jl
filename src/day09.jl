module day09

export solve1, solve2

function calc_diff(seq)
  diff = []
  for i = 1:length(seq)-1
    x = seq[i]
    y = seq[i+1]
    push!(diff, y-x)
  end
  diff
end

function predict_seq(seq, rev=false)
  diff = [seq]
  while !all(==(0), diff[end])
    push!(diff, calc_diff(diff[end]))
  end
  for i = length(diff)-1:-1:1
    if rev
      lastdiff = diff[i][begin] - diff[i+1][begin]
    else
      lastdiff = diff[i][end] + diff[i+1][end]
    end
    pushf! = rev ? pushfirst! : push!
    pushf!(diff[i], lastdiff)
  end
  if rev
    diff[1][begin]
  else
    diff[1][end]
  end
end

function solve1(in)
  seqs = map(filter(!isempty, split(in, "\n"))) do seq
    parse.(Int, split(seq, r"\s+"))
  end
  reduce(+, predict_seq.(seqs))
end

function solve2(in)
  seqs = map(filter(!isempty, split(in, "\n"))) do seq
    parse.(Int, split(seq, r"\s+"))
  end
  reduce(+, predict_seq.(seqs, true))
end

end
