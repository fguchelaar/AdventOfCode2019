import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testExample() throws {
        let puzzle = Puzzle(input: "")
        XCTAssertEqual(puzzle.part1(), 0)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
