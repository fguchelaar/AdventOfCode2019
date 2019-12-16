import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testPattern() {
        let puzzle = Puzzle(input: "")
        XCTAssertEqual(puzzle.pattern(for: 0), [1,0,-1,0])
        XCTAssertEqual(puzzle.pattern(for: 1), [0, 1, 1, 0, 0, -1, -1,0])
    }

    func test12345678() {
        let puzzle = Puzzle(input: "12345678")
        XCTAssertEqual(puzzle.apply(phases: 0), "12345678")
        XCTAssertEqual(puzzle.apply(phases: 1), "48226158")
        XCTAssertEqual(puzzle.apply(phases: 2), "34040438")
        XCTAssertEqual(puzzle.apply(phases: 3), "03415518")
        XCTAssertEqual(puzzle.apply(phases: 4), "01029498")
    }

    func testPart1Example1() {
        let puzzle = Puzzle(input: "80871224585914546619083218645595")
        XCTAssertEqual(puzzle.part1(), "24176176")
    }

    func testPart1Example2() {
        let puzzle = Puzzle(input: "80871224585914546619083218645595")
        XCTAssertEqual(puzzle.part1(), "24176176")
    }

    func testPart1Example3() {
        let puzzle = Puzzle(input: "80871224585914546619083218645595")
        XCTAssertEqual(puzzle.part1(), "24176176")
    }

    func testPart2Example1() {
        let puzzle = Puzzle(input: "03036732577212944063491565474664")
        XCTAssertEqual(puzzle.part2(), "84462026")
    }

    func testPart2Example2() {
        let puzzle = Puzzle(input: "02935109699940807407585447034323")
        XCTAssertEqual(puzzle.part2(), "78725270")
    }

    func testPart2Example3() {
        let puzzle = Puzzle(input: "03081770884921959731165446850517")
        XCTAssertEqual(puzzle.part2(), "53553731")
    }

    static var allTests = [
        ("test12345678", test12345678),
        ("testPart1Example1", testPart1Example1),
        ("testPart1Example2", testPart1Example2),
        ("testPart1Example3", testPart1Example3),
    ]
}
