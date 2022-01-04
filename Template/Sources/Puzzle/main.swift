import AdventKit
import Foundation

let puzzle = Puzzle(input: try! String(contentsOfFile: "input.txt"))

print("Part 1: \(puzzle.part1())")
print("Part 2: \(puzzle.part2())")
