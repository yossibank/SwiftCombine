@testable import SwiftCombine
import XCTest

final class JokeGetViewModelTests: XCTestCase {
    private var viewModel: JokeGetViewModel!

    override func setUpWithError() throws {
        viewModel = JokeGetViewModel(model: Model.Joke.Get(useTestData: true))
    }

    func testFetch() throws {
        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)

        let expectation = try TestDataFetchRequest(
            testDataJsonPath: JokeGetRequest(
                parameters: .init(),
                pathComponent: "R7UfaahVfFd"
            ).testDataPath
        )
        .fetchLocalTestData(responseType: JokeResponse.self)
        .map(JokeMapper().convert)
        .get()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectation))
    }
}
