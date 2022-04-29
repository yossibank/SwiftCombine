@testable import SwiftCombine
import XCTest

final class RequestTests: XCTestCase {
    override func setUpWithError() throws {
        PersistedDataHolder.onboardingFinished = false
    }

    func testGetJoke() {
        let expectation = XCTestExpectation(description: "get joke")

        Repos.Joke().request(
            useTestData: true,
            parameters: .init(),
            pathComponent: .init()
        ) { result in
            switch result {
            case let .success(response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.status, 200)
                expectation.fulfill()

            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 3.0)
    }
}
