import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testPart1Example1()  {
        let puzzle = Puzzle(input: try! String(contentsOfFile: "test1.txt"))
        XCTAssertEqual(puzzle.part1(), 23)
    }

    func testPart1Example2()  {
        let puzzle = Puzzle(input: try! String(contentsOfFile: "test2.txt"))
        XCTAssertEqual(puzzle.part1(), 58)
    }

    func testPart2Example()  {
        let puzzle = Puzzle(input: try! String(contentsOfFile: "test3.txt"))
        XCTAssertEqual(puzzle.part2(), 396)
    }

    static var allTests = [
        ("testPart1Example1", testPart1Example1),
        ("testPart1Example2", testPart1Example2),
        ("testPart2Example", testPart2Example),
    ]
}
