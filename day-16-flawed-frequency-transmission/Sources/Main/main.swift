import Puzzle

let puzzle = Puzzle(input: try! String(contentsOfFile: "/Users/frank/Workspace/github/fguchelaar/AdventOfCode2019/day-16-flawed-frequency-transmission/input.txt"))

print("Part 1: \(puzzle.part1())")
print("Part 2: \(puzzle.part2())")