module test_day09

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day09

ex1 = "0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45"

@testset "day09" begin
  @test solve1(ex1) == 114
  @test solve1(readinput("day09")) == 1868368343
  @test solve2(ex1) == 2
  @test solve2(readinput("day09")) == 1022
end

end
