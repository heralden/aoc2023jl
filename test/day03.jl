module test_day03

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day03

ex1 = "467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...\$.*....
.664.598.."

edge1 = "12.......*..
+.........34
.......-12..
..78........
..*....60...
78..........
.......23...
....90*12...
............
2.2......12.
.*.........*
1.1.......56"

@testset "day03" begin
  @test solve1(edge1) == 413
  @test solve1(ex1) == 4361
  @test solve1(readinput("day03")) == 525911
  @test solve2(ex1) == 467835
  @test solve2(readinput("day03")) == 75805607
end

end
