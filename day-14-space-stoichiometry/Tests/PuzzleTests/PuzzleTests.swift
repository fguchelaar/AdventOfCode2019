import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {
    
    func testParseReaction() {
        let reaction = Puzzle.parse(reaction: "1 ORE => 1 FUEL")
        
        XCTAssertEqual(reaction.output, "FUEL")
        XCTAssertEqual(reaction.amount, 1)
        XCTAssertEqual(reaction.inputs, ["ORE": 1])
    }
    
    func testParseReactions() {
        let puzzle = Puzzle(input: """
        9 ORE => 2 A
        8 ORE => 3 B
        7 ORE => 5 C
        3 A, 4 B => 1 AB
        5 B, 7 C => 1 BC
        4 C, 1 A => 1 CA
        2 AB, 3 BC, 4 CA => 1 FUEL
        """)
        
        XCTAssertEqual(puzzle.reactions.count, 7)
        let fuel = puzzle.reactions.first { $0.output == "FUEL" }
        XCTAssertNotNil(fuel)
        XCTAssertEqual(fuel!.amount, 1)
        XCTAssertEqual(fuel!.inputs, ["AB": 2, "BC": 3, "CA": 4])
    }
    
    func testPart1Example1() {
        let puzzle = Puzzle(input: """
        10 ORE => 10 A
        1 ORE => 1 B
        7 A, 1 B => 1 C
        7 A, 1 C => 1 D
        7 A, 1 D => 1 E
        7 A, 1 E => 1 FUEL
        """)
        
        XCTAssertEqual(puzzle.part1(), 31)
    }
    
    func testPart1Example2() {
        let puzzle = Puzzle(input: """
        9 ORE => 2 A
        8 ORE => 3 B
        7 ORE => 5 C
        3 A, 4 B => 1 AB
        5 B, 7 C => 1 BC
        4 C, 1 A => 1 CA
        2 AB, 3 BC, 4 CA => 1 FUEL
        """)
        
        XCTAssertEqual(puzzle.part1(), 165)
    }
    
    func testPart1Example3() {
        let puzzle = Puzzle(input: """
        157 ORE => 5 NZVS
        165 ORE => 6 DCFZ
        44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
        12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
        179 ORE => 7 PSHF
        177 ORE => 5 HKGWZ
        7 DCFZ, 7 PSHF => 2 XJWVT
        165 ORE => 2 GPVTF
        3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
        """)
        
        XCTAssertEqual(puzzle.part1(), 13312)
    }

    func testPart2Example1() {
        let puzzle = Puzzle(input: """
        157 ORE => 5 NZVS
        165 ORE => 6 DCFZ
        44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
        12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
        179 ORE => 7 PSHF
        177 ORE => 5 HKGWZ
        7 DCFZ, 7 PSHF => 2 XJWVT
        165 ORE => 2 GPVTF
        3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
        """)

        XCTAssertEqual(puzzle.part2(), 82_892_753)
    }

    func testPart2Example2() {
        let puzzle = Puzzle(input: """
        2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
        17 NVRVD, 3 JNWZP => 8 VPVL
        53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
        22 VJHF, 37 MNCFX => 5 FWMGM
        139 ORE => 4 NVRVD
        144 ORE => 7 JNWZP
        5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
        5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
        145 ORE => 6 MNCFX
        1 NVRVD => 8 CXFTF
        1 VJHF, 6 MNCFX => 4 RFSQX
        176 ORE => 6 VJHF
        """)

        XCTAssertEqual(puzzle.part2(), 5586022)
    }

    func testPart2Example3() {
        let puzzle = Puzzle(input: """
        171 ORE => 8 CNZTR
        7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
        114 ORE => 4 BHXH
        14 VRPVC => 6 BMBT
        6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
        6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
        15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
        13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
        5 BMBT => 4 WPTQ
        189 ORE => 9 KTJDG
        1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
        12 VRPVC, 27 CNZTR => 2 XDBXC
        15 KTJDG, 12 BHXH => 5 XCVML
        3 BHXH, 2 VRPVC => 7 MZWV
        121 ORE => 7 VRPVC
        7 XCVML => 6 RJRHP
        5 BHXH, 4 VRPVC => 5 LTCX
        """)

        XCTAssertEqual(puzzle.part2(), 460664)
    }

    static var allTests = [
        ("testParseReaction", testParseReaction),
        ("testParseReactions", testParseReactions),
        ("testPart1Example1", testPart1Example1),
        ("testPart1Example2", testPart1Example2),
        ("testPart1Example3", testPart1Example3),
        ("testPart2Example1", testPart2Example1),
        ("testPart2Example2", testPart2Example2),
        ("testPart2Example3", testPart2Example3),
    ]
}
