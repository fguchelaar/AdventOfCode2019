import XCTest
@testable import AdventKit

final class PointTests: XCTestCase {
    func testManhattan() {
        XCTAssertEqual(Point(x: 0, y:0).manhattan(to: Point(x:0, y: 0)), 0)
        XCTAssertEqual(Point(x: 10, y:10).manhattan(to: Point(x:0, y: 0)), 20)
        XCTAssertEqual(Point(x: 5, y:2).manhattan(to: Point(x:-5, y: -2)), 14)
        XCTAssertEqual(Point(x: 1023, y:-521).manhattan(to: Point(x:-364, y: 9003)), 10911)
    }

    func testAddition() {
        XCTAssertEqual(Point(x: 0, y: 0) + Point(x: 3, y: 3), Point(x: 3, y: 3))
        XCTAssertEqual(Point(x: 10, y: 3) + Point(x: 3, y: 3), Point(x: 13, y: 6))
        XCTAssertEqual(Point(x: 1, y: -5) + Point(x: -3, y: -3), Point(x: -2, y: -8))
    }

    static var allTests = [
        ("testManhattan", testManhattan),
        ("testAddition", testAddition),
    ]
}
