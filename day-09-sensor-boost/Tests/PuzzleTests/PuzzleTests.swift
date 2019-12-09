import XCTest
@testable import Puzzle

final class PuzzleTests: XCTestCase {

    func testCopyOfInput() {
        let program = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
        let ic = IntCode(memory: program)
        ic.runProgram(inputs: [Int]())
        XCTAssertEqual(ic.output, program)
    }

    func test16DigitOutput() {
        let ic = IntCode(memory: [1102,34915192,34915192,7,4,7,99,0])
        ic.runProgram(inputs: [Int]())
        XCTAssertEqual(String(ic.output.last!).count, 16)
    }

    func testLargeOutput() {
        let ic = IntCode(memory: [104,1125899906842624,99])
        ic.runProgram(inputs: [Int]())
        XCTAssertEqual(ic.output.last!, 1125899906842624)
    }

    static var allTests = [
        ("testCopyOfInput", testCopyOfInput),
        ("test16DigitOutput", test16DigitOutput),
        ("testLargeOutput", testLargeOutput),
    ]
}
