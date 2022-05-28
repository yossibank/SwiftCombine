@testable import SwiftCombine
import XCTest

final class JokeSlackViewModelTests: XCTestCase {
    private var viewModel: JokeSlackViewModel!

    override func setUpWithError() throws {
        viewModel = JokeSlackViewModel(
            usecase: Domain.Usecase.Joke.Slack(useTestData: true)
        )
    }

    func testFetch() throws {
        let publisher = viewModel.$state.collect(1).first()

        viewModel.fetch()

        let result = try awaitPublisher(publisher)
        
        let expectation = try TestDataFetchRequest(
            testDataJsonPath: JokeSlackRequest(
                parameters: .init(),
                pathComponent: .init()
            ).testDataPath
        )
        .fetchLocalTestData(responseType: JokeSlackResponse.self)
        .map(JokeSlackMapper().convert)
        .get()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first, .done(expectation))
    }
}
