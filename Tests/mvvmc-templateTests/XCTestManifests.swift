import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(mvvmc_templateTests.allTests),
    ]
}
#endif