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

ex2 = "...........
.S-------7.
.|F-----7|.
.||.....||.
.||.....||.
.|L-7.F-J|.
.|..|.|..|.
.L--J.L--J.
..........."

ex3 = "FF7FSF7F7F7F7F7F---7
L|LJ||||||||||||F--J
FL-7LJLJ||||||LJL-77
F--JF--7||LJLJ7F7FJ-
L---JF-JLJ.||-FJLJJ7
|F|F-JF---7F7-L7L|7|
|FFJF7L7F-JF7|JL---7
7-L-JL7||F7|L7F-7F7|
L.L7LFJ|||||FJL7||LJ
L7JLJL-JLJLJL--JLJ.L"

@testset "day10" begin
  @test solve1(ex1) == 8
  @test solve1(readinput("day10")) == 6714
  @test solve2(ex2) == 4
  @test solve2(ex3) == 10
  @test solve2(readinput("day10")) == 429
end

end
