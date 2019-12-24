import XCTest
@testable import Puzzle

final class RecursiveErisTests: XCTestCase {

    func testExample()  {
        let eris = RecursiveEris(map: """
        ....#
        #..#.
        #.?##
        ..#..
        #....
        """)

        (0..<10).forEach { _ in
            eris.step()
        }

        XCTAssertEqual(eris.count, 99)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
