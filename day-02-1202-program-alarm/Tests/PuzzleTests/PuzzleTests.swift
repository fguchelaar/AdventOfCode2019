import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testRestoreProgram() throws {
        let puzzle = Puzzle(input: "")
        XCTAssertEqual(puzzle.restore([1,0,0,0,99], noun: 0, verb: 0), [2,0,0,0,99])
        XCTAssertEqual(puzzle.restore([2,3,0,3,99], noun: 3, verb: 0), [2,3,0,6,99])
        XCTAssertEqual(puzzle.restore([2,4,4,5,99,0], noun: 4, verb: 4), [2,4,4,5,99,9801])
        XCTAssertEqual(puzzle.restore([1,1,1,4,99,5,6,0,99], noun: 1, verb: 1), [30,1,1,4,2,5,6,0,99])
    }

    static var allTests = [
        ("testExample", testRestoreProgram),
    ]
}
