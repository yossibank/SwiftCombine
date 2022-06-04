@testable import SwiftCombine
import XCTest

final class RequestTests: XCTestCase {
    func testGetJoke() {
        let expectation = XCTestExpectation(description: "Get Joke")

        APIClient().request(
            item: JokeRequest(
                parameters: .init(),
                pathComponent: .init()
            ),
            useTestData: true
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

        APIClient().request(
            item: JokeRandomRequest(
                parameters: .init(),
                pathComponent: .init()
            ),
            useTestData: true
        ) { result in
            switch result {
            case let .success(response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.status, 200)
                AppDataHolder.jokeId = ""
                expectation.fulfill()

            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testGetJokeSearch() {
        let expectation = XCTestExpectation(description: "Get Joke Search")

        APIClient().request(
            item: JokeSearchRequest(
                parameters: .init(),
                pathComponent: .init()
            ),
            useTestData: true
        ) { result in
            switch result {
            case let .success(response):
                XCTAssertNotNil(response)
                XCTAssertEqual(response.status, 200)
                XCTAssertEqual(response.results.count, 3)
                expectation.fulfill()

            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }

        wait(for: [expectation], timeout: 3.0)
    }

    func testGetJokeSlack() {
        let expectation = XCTestExpectation(description: "Get Joke Slack")

        APIClient().request(
            item: JokeSlackRequest(
                parameters: .init(),
                pathComponent: .init()
            ),
            useTestData: true
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
