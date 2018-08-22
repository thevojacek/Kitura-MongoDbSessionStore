import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(Kitura_MongoDbSessionStoreTests.allTests),
    ]
}
#endif