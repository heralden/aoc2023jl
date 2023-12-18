module test_day10

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day10

ex1 = "7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ"

@testset "day10" begin
  @test solve1(ex1) == 8
  @test solve1(readinput("day10")) == 6714
  # @test solve2(ex1) == 0
  # @test solve2(readinput("day10")) == 0
end

end
