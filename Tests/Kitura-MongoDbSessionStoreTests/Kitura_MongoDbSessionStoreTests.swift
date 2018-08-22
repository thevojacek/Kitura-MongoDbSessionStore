import XCTest
@testable import Kitura_MongoDbSessionStore

final class Kitura_MongoDbSessionStoreTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Kitura_MongoDbSessionStore().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
