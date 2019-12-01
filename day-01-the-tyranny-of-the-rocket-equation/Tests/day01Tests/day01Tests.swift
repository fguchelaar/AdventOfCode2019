import XCTest
@testable import Puzzle

final class day01Tests: XCTestCase {

    func testRequiredFuel() throws {
        let puzzle = Puzzle(input: "")
        XCTAssertEqual(puzzle.requiredFuel(for: 12), 2)
        XCTAssertEqual(puzzle.requiredFuel(for: 14), 2)
        XCTAssertEqual(puzzle.requiredFuel(for: 1969), 654)
        XCTAssertEqual(puzzle.requiredFuel(for: 100756), 33583)
    }

    func testTotalRequiredFuel() throws {
        let puzzle = Puzzle(input: "")
        XCTAssertEqual(puzzle.totalRequiredFuel(for: 14), 2)
        XCTAssertEqual(puzzle.totalRequiredFuel(for: 1969), 966)
        XCTAssertEqual(puzzle.totalRequiredFuel(for: 100756), 50346)
    }

    static var allTests = [
        ("testRequiredFuel", testRequiredFuel),
        ("testTotalRequiredFuel", testTotalRequiredFuel),
    ]
}
