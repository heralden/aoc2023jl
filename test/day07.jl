module test_day07

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day07

ex1 = "32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"

edge1 = "2345A 1
Q2KJJ 13
Q2Q2Q 19
T3T3J 17
T3Q33 11
2345J 3
J345A 2
32T3K 5
T55J5 29
KK677 7
KTJJT 34
QQQJA 31
JJJJJ 37
JAAAA 43
AAAAJ 59
AAAAA 61
2AAAA 23
2JJJJ 53
JJJJ2 41"

@testset "day07" begin
  @test solve1(ex1) == 6440
  @test solve1(edge1) == 6592
  @test solve1(readinput("day07")) == 248396258
  # @test solve2(ex1) == 0
  # @test solve2(readinput("day07")) == 0
end

end
