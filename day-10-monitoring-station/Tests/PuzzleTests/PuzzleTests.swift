import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testExample1() throws {
        let puzzle = Puzzle(input: """
        .#..#
        .....
        #####
        ....#
        ...##
        """)
        XCTAssertEqual(puzzle.part1(), 8)
    }

    func testExample2() throws {
        let puzzle = Puzzle(input: """
        ......#.#.
        #..#.#....
        ..#######.
        .#.#.###..
        .#..#.....
        ..#....#.#
        #..#....#.
        .##.#..###
        ##...#..#.
        .#....####
        """)
        XCTAssertEqual(puzzle.part1(), 33)
    }

    func testExample3() throws {
        let puzzle = Puzzle(input: """
        #.#...#.#.
        .###....#.
        .#....#...
        ##.#.#.#.#
        ....#.#.#.
        .##..###.#
        ..#...##..
        ..##....##
        ......#...
        .####.###.
        """)
        XCTAssertEqual(puzzle.part1(), 35)
    }

    func testExample4() throws {
        let puzzle = Puzzle(input: """
        .#..#..###
        ####.###.#
        ....###.#.
        ..###.##.#
        ##.##.#.#.
        ....###..#
        ..#.#..#.#
        #..#.#.###
        .##...##.#
        .....#.#..
        """)
        XCTAssertEqual(puzzle.part1(), 41)
    }

    func testExample5() throws {
        let puzzle = Puzzle(input: """
        .#..##.###...#######
        ##.############..##.
        .#.######.########.#
        .###.#######.####.#.
        #####.##.#.##.###.##
        ..#####..#.#########
        ####################
        #.####....###.#.#.##
        ##.#################
        #####.##.###..####..
        ..######..##.#######
        ####.##.####...##..#
        .#####..#.######.###
        ##...#.##########...
        #.##########.#######
        .####.#.###.###.#.##
        ....##.##.###..#####
        .#.#.###########.###
        #.#.#.#####.####.###
        ###.##.####.##.#..##
        """)
        XCTAssertEqual(puzzle.part1(), 210)
        XCTAssertEqual(puzzle.part2(), 802)
    }

    static var allTests = [
        ("testExample1", testExample1),
        ("testExample2", testExample2),
        ("testExample3", testExample3),
        ("testExample4", testExample4),
        ("testExample5", testExample5),
    ]
}
