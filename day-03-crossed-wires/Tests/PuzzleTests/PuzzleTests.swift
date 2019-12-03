import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testParseLine() {
        let line = "R75,U15"
        let parsed = Puzzle.parse(line: line)
        XCTAssertEqual(parsed[0].direction, "R")
        XCTAssertEqual(parsed[0].steps, 75)

        XCTAssertEqual(parsed[1].direction, "U")
        XCTAssertEqual(parsed[1].steps, 15)
    }

    func testPart1Example1() {
        let testInput = """
            R75,D30,R83,U83,L12,D49,R71,U7,L72
            U62,R66,U55,R34,D71,R55,D58,R83
            """;
        let puzzle = Puzzle(input: testInput)
        XCTAssertEqual(puzzle.part1(), 159)
    }
    
    func testPart1Example2() {
        let testInput = """
            R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
            U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
            """;
        let puzzle = Puzzle(input: testInput)
        XCTAssertEqual(puzzle.part1(), 135)
    }

    func testPart2Example1() {
        let testInput = """
            R75,D30,R83,U83,L12,D49,R71,U7,L72
            U62,R66,U55,R34,D71,R55,D58,R83
            """;
        let puzzle = Puzzle(input: testInput)
        XCTAssertEqual(puzzle.part2(), 610)
    }

    func testPart2Example2() {
        let testInput = """
            R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
            U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
            """;
        let puzzle = Puzzle(input: testInput)
        XCTAssertEqual(puzzle.part2(), 410)
    }

    static var allTests = [
        ("testParseLine", testParseLine),
        ("testPart1Example1", testPart1Example1),
        ("testPart1Example2", testPart1Example2),
        ("testPart2Example1", testPart2Example1),
        ("testPart2Example2", testPart2Example2),
    ]
}
