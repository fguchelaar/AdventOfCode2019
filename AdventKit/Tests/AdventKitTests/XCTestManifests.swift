import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AdventKitTests.allTests),
        testCase(PointTests.allTests),
    ]
}
#endif
