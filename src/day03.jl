module day03

export solve1, solve2

struct PartNo
  no
  x1
  x2
  y
end

struct Symbol
  sym
  x
  y
end

function isadjacent(part::PartNo, sym::Symbol)
  return part.x1-1 <= sym.x <= part.x2+1 &&
    part.y-1 <= sym.y <= part.y+1
end

function read_schematic(schem)
  partnos = []
  syms = []

  for y = 1:length(schem)
    partno = []
    x1 = 0
    for x = 1:length(schem[1])
      char = schem[y][x]
      if isdigit(char)
        if isempty(partno)
          x1 = x
        end
        push!(partno, char)
      end
      if !isdigit(char) || x == length(schem[1])
        if !isempty(partno)
          no = parse(Int, join(partno))
          push!(partnos, PartNo(no, x1, x-1, y))
          empty!(partno)
        end

        if !isdigit(char) && char != '.'
          push!(syms, Symbol(char, x, y))
        end
      end
    end
  end

  return (partnos, syms)
end

function solve1(in)
  schem = filter(a -> !isempty(a), split(in, "\n"))
  (partnos, syms) = read_schematic(schem)

  valid_partnos = filter(partnos) do partno
    return any(sym -> isadjacent(partno, sym), syms)
  end

  return sum(map(partno -> partno.no, valid_partnos))
end

function solve2(in)
  schem = filter(a -> !isempty(a), split(in, "\n"))
  (partnos, syms) = read_schematic(schem)

  gear_ratios = []
  for sym in syms
    if sym.sym == '*'
      adjacents = filter(partno -> isadjacent(partno, sym), partnos)
      if length(adjacents) == 2
        push!(gear_ratios, reduce(*, map(partno -> partno.no, adjacents)))
      end
    end
  end

  return sum(gear_ratios)
end

end
