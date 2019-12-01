import XCTest
@testable import Puzzle

final class dayNNTests: XCTestCase {

    func testExample() throws {
        let puzzle = Puzzle(input: "")
        XCTAssertEqual(puzzle.part1(), "")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
