import XCTest
@testable import RayTracingWeekend

class RayTracingWeekendTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(RayTracingWeekend().text, "Hello, World!")
    }


    static var allTests : [(String, (RayTracingWeekendTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
