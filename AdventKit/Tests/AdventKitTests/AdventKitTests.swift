//
//  File.swift
//  
//
//  Created by Frank Guchelaar on 13/12/2019.
//

import XCTest
@testable import AdventKit

final class AdventKitTest: XCTestCase {

    func testGCD() {
        XCTAssertEqual(gcd(15, 10), 5)
        XCTAssertEqual(gcd(91, 14), 7)

        XCTAssertEqual(gcd(91), 91)

        XCTAssertEqual(gcd(25, 15, 10), 5)
        XCTAssertEqual(gcd([25, 15, 10]), 5)
    }

    func testLCM() {
        XCTAssertEqual(lcm(231, 924), 924)

        XCTAssertEqual(lcm(231), 231)

        XCTAssertEqual(lcm(231, 924, 1386), 2772)
        XCTAssertEqual(lcm([231, 924, 2772]), 2772)
    }

    static var allTests = [
        ("testGCD", testGCD),
        ("testLCM", testLCM),
    ]
}
