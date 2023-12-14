module test_day05

using Test
include("./utils.jl")
using .utils
using aoc2023jl.day05

ex1 = "seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4"

@testset "day05" begin
  @test solve1(ex1) == 35
  @test solve1(readinput("day05")) == 910845529
  @test solve2(ex1) == 46
  @test solve2(readinput("day05")) == 77435348
end

end
