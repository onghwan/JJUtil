import XCTest
@testable import JJUtil

final class JJUtilTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(JJUtil().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
