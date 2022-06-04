@testable import SwiftCombine
import XCTest

final class JokeGetViewModelTests: XCTestCase {
    private var viewModel: JokeViewModel!

    override func setUpWithError() throws {
        viewModel = JokeViewModel(
            usecase: Domain.Usecase.Joke.Get(useTestData: true),
            jokeId: "R7UfaahVfFd"
        )
    }

    func testFetch() throws {
        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)

        let expectation = try TestDataFetchRequest(
            testDataJsonPath: JokeRequest(
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
