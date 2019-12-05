import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testExample() {
        let ic = IntCode(memory: [3,0,4,0,99], input: 135)
        ic.runProgram()
        XCTAssertEqual(ic.output.last!, 135)
    }

    func testOldProgram() {

        let ic = IntCode(memory: [1,1,1,4,99,5,6,0,99], input: 1)
        ic.runProgram()
        XCTAssertEqual(ic.memory, [30,1,1,4,2,5,6,0,99])
    }

    func test3() {

        let ic = IntCode(memory: [1002,4,3,4,33], input: 1)
        ic.runProgram()
        XCTAssertEqual(ic.memory, [1002,4,3,4,99])
    }

    func test4() {
        let ic = IntCode(memory: [1101,100,-1,4,0], input: 1)
        ic.runProgram()
        XCTAssertEqual(ic.memory, [1101,100,-1,4,99])
    }

    func test5() {
        let memory = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
        1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
        999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]

        let ic = IntCode(memory: memory, input: 9)
        ic.runProgram()
        XCTAssertEqual(ic.output[0], 1001)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
