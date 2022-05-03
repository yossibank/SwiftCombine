@testable import SwiftCombine
import XCTest

final class RequestTests: XCTestCase {
    func testGetJoke() {
        let expectation = XCTestExpectation(description: "Get Joke")

        Repos.Joke.Get().request(
            useTestData: true,
            parameters: .init(),
            pathComponent: "R7UfaahVfFd"
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
    
    func testGetJokeRandom() {
        let expectation = XCTestExpectation(description: "Get Joke Random")

        Repos.Joke.Random().request(
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

    func testGetJokeSlack() {
        let expectation = XCTestExpectation(description: "Get Joke Slack")

        Repos.Joke.Slack().request(
            useTestData: true,
            parameters: .init(),
            pathComponent: .init()
        ) { result in
            switch result {
            case let .success(response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.username, "icanhazdadjoke")
                expectation.fulfill()

            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 3.0)
    }
}
