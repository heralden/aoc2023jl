module test_day06

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day06

ex1 = "Time:      7  15   30
Distance:  9  40  200"

@testset "day06" begin
  @test solve1(ex1) == 288
  @test solve1(readinput("day06")) == 5133600
  @test solve2(ex1) == 71503
  @test solve2(readinput("day06")) == 40651271
end

end
