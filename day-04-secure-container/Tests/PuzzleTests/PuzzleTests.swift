import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testPart1Example() throws {
        let puzzle = Puzzle(input: "0-0")
        XCTAssertTrue(puzzle.isValid(password: 111111))
        XCTAssertFalse(puzzle.isValid(password: 223450))
        XCTAssertFalse(puzzle.isValid(password: 123789))
    }

    func testPart2Example() throws {
        let puzzle = Puzzle(input: "0-0")
        XCTAssertTrue(puzzle.isValid2(password: 112233))
        XCTAssertFalse(puzzle.isValid2(password: 123444))
        XCTAssertTrue(puzzle.isValid2(password: 111122))
    }

    static var allTests = [
        ("testPart1Example", testPart1Example),
        ("testPart2Example", testPart2Example),
    ]
}
