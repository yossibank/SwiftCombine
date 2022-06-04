@testable import SwiftCombine
import XCTest

final class UserDefaultsTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        UserDefaults(suiteName: "Test")?.removePersistentDomain(forName: "Test")
    }

    func testOnboardingFinished() {
        XCTAssertEqual(AppDataHolder.jokeId, "")

        AppDataHolder.jokeId = "JOKEJOKE"
        XCTAssertEqual(AppDataHolder.jokeId, "JOKEJOKE")

        AppDataHolder.jokeId = ""
        XCTAssertEqual(AppDataHolder.jokeId, "")
    }

    func testServerType() {
        XCTAssertEqual(AppDataHolder.serverType, .production)

        AppDataHolder.serverType = .stage
        XCTAssertEqual(AppDataHolder.serverType, .stage)

        AppDataHolder.serverType = .prestage
        XCTAssertEqual(AppDataHolder.serverType, .prestage)

        AppDataHolder.serverType = .production
        XCTAssertEqual(AppDataHolder.serverType, .production)
    }
}
