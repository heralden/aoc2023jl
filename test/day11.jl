module test_day11

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day11

ex1 = "...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#....."

@testset "day11" begin
  @test solve1(ex1) == 374
  @test solve1(readinput("day11")) == 9556712
  @test solve2(ex1) == 82000210
  @test solve2(readinput("day11")) == 678626199476
end

end
