module test_day08

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day08

ex1 = "RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)"

ex2 = "LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)"

ex3 = "LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)"

@testset "day08" begin
  @test solve1(ex1) == 2
  @test solve1(ex2) == 6
  @test solve1(readinput("day08")) == 16697
  @test solve2(ex3) == 6
  @test solve2(readinput("day08")) == 10668805667831
end

end
