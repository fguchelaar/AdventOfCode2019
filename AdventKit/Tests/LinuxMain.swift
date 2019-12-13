import XCTest

import AdventKitTests

var tests = [XCTestCaseEntry]()
tests += PointTests.allTests()
tests += AdventKitTests.allTests()
XCTMain(tests)
