@testable import Puzzle
import XCTest

final class PuzzleTests: XCTestCase {
    func testPart1Example1() {
        let puzzle = Puzzle(input: """
        #########
        #b.A.@.a#
        #########
        """)
        XCTAssertEqual(puzzle.part1(), 8)
    }
    
    func testPart1Example2() {
        let puzzle = Puzzle(input: """
        ########################
        #f.D.E.e.C.b.A.@.a.B.c.#
        ######################.#
        #d.....................#
        ########################
        """)
        XCTAssertEqual(puzzle.part1(), 86)
    }
    
    func testPart1Example3() {
        let puzzle = Puzzle(input: """
        ########################
        #...............b.C.D.f#
        #.######################
        #.....@.a.B.c.d.A.e.F.g#
        ########################
        """)
        XCTAssertEqual(puzzle.part1(), 132)
    }
    
    func testPart1Example4() {
        let puzzle = Puzzle(input: """
        #################
        #i.G..c...e..H.p#
        ########.########
        #j.A..b...f..D.o#
        ########@########
        #k.E..a...g..B.n#
        ########.########
        #l.F..d...h..C.m#
        #################
        """)
        XCTAssertEqual(puzzle.part1(), 136)
    }
    
    func testPart1Example5() {
        let puzzle = Puzzle(input: """
        ########################
        #@..............ac.GI.b#
        ###d#e#f################
        ###A#B#C################
        ###g#h#i################
        ########################
        """)
        XCTAssertEqual(puzzle.part1(), 81)
    }
    
    func testPart2Example1() {
        let puzzle = Puzzle(input: """
        #######
        #a.#Cd#
        ##...##
        ##.@.##
        ##...##
        #cB#Ab#
        #######
        """)
        XCTAssertEqual(puzzle.part2(), 8)
    }

    func testPart2Example2() {
        let puzzle = Puzzle(input: """
        ###############
        #d.ABC.#.....a#
        ######...######
        ######.@.######
        ######...######
        #b.....#.....c#
        ###############
        """)
        XCTAssertEqual(puzzle.part2(), 24)
    }

    func testPart2Example3() {
        let puzzle = Puzzle(input: """
        #############
        #DcBa.#.GhKl#
        #.###...#I###
        #e#d#.@.#j#k#
        ###C#...###J#
        #fEbA.#.FgHi#
        #############
        """)
        XCTAssertEqual(puzzle.part2(), 32)
    }

    func testPart2Example4() {
        let puzzle = Puzzle(input: """
        #############
        #g#f.D#..h#l#
        #F###e#E###.#
        #dCba...BcIJ#
        #####.@.#####
        #nK.L...G...#
        #M###N#H###.#
        #o#m..#i#jk.#
        #############
        """)
        XCTAssertEqual(puzzle.part2(), 72)
    }
}
