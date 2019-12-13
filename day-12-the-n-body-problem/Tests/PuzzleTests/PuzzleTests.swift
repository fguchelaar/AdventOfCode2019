import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    let example1 = """
        <x=-1, y=0, z=2>
        <x=2, y=-10, z=-7>
        <x=4, y=-8, z=8>
        <x=3, y=5, z=-1>
        """

    let example2 = """
        <x=-8, y=-10, z=0>
        <x=5, y=5, z=10>
        <x=2, y=-7, z=3>
        <x=9, y=-8, z=-3>
        """

    func testPart1Example1() {
        let puzzle = Puzzle(input: example1)
        XCTAssertEqual(puzzle.part1(steps: 10), 179)
    }

    func testPart1Example2() {
        let puzzle = Puzzle(input: example2)
        XCTAssertEqual(puzzle.part1(steps: 100), 1940)
    }

    func testPart2Example1() {
        let puzzle = Puzzle(input: example1)
        XCTAssertEqual(puzzle.part2(), 2772)
    }

    func testPart2Example2() {
        let puzzle = Puzzle(input: example2)
        XCTAssertEqual(puzzle.part2(), 4686774924)
    }

    static var allTests = [
        ("testPart1Example1", testPart1Example1),
        ("testPart1Example2", testPart1Example2),
        ("testPart2Example1", testPart2Example1),
        ("testPart2Example2", testPart2Example2),
    ]
}
