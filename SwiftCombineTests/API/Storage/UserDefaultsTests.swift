@testable import SwiftCombine
import XCTest

final class UserDefaultsTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        UserDefaults(suiteName: "mock")?.removePersistentDomain(forName: "mock")
    }

    func testOnboardingFinished() {
        @UserDefaultsStorage(UserDefaultKey.onboardingFinished.rawValue, defaultValue: false, type: .mock)
        var onboardingFinished: Bool

        XCTAssertFalse(onboardingFinished)

        onboardingFinished = true
        XCTAssertTrue(onboardingFinished)

        onboardingFinished = false
        XCTAssertFalse(onboardingFinished)
    }

    func testServerType() {
        @UserDefaultsEnumStorage(UserDefaultKey.serverType.rawValue, defaultValue: .stage, type: .mock)
        var serverType: UserDefaultEnumKey.ServerType

        XCTAssertEqual(serverType, .stage)

        serverType = .production
        XCTAssertEqual(serverType, .production)

        serverType = .prestage
        XCTAssertEqual(serverType, .prestage)

        serverType = .stage
        XCTAssertEqual(serverType, .stage)
    }
}
