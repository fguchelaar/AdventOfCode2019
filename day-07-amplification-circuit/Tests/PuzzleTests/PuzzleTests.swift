import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testPar1Example1() throws {
        let puzzle = Puzzle(input: "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0")
        XCTAssertEqual(puzzle.part1(), 43210)
    }

    func testPart1Example2() throws {
        let puzzle = Puzzle(input: "3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0")
        XCTAssertEqual(puzzle.part1(), 54321)
    }

    func testPart2Example1() {
        let puzzle = Puzzle(input: "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5")
        XCTAssertEqual(puzzle.part2(), 139629729)
    }

    func testPart2Example2() {
        let puzzle = Puzzle(input: "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10")
        XCTAssertEqual(puzzle.part2(), 18216)
    }

    static var allTests = [
        ("testPar1Example1", testPar1Example1),
        ("testPart1Example2", testPart1Example2),
        ("testPart2Example1", testPart2Example1),
        ("testPart2Example2", testPart2Example2),
    ]
}
