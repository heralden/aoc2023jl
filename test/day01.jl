module test_day01

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day01

ex1 = "1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"

ex2 = "two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"

@testset "day01" begin
  @test solve1(ex1) == 142
  @test solve1(readinput("day01")) == 54697
  @test solve2(ex2) == 281
  @test solve2(readinput("day01")) == 54885
end

end
