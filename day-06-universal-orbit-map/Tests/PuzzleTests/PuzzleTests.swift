import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testExample() throws {

        let input = """
            COM)B
            B)C
            C)D
            D)E
            E)F
            B)G
            G)H
            D)I
            E)J
            J)K
            K)L
            """

        let puzzle = Puzzle(input: input)
        XCTAssertEqual(puzzle.part1(), 42)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
