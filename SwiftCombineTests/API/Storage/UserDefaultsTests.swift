@testable import SwiftCombine
import XCTest

final class UserDefaultsTests: XCTestCase {
    func testGetIsFinished() {
        XCTAssertFalse(Repos.Onboarding.GetIsFinished().request()!)

        PersistedDataHolder.onboardingFinished = true
        XCTAssertTrue(Repos.Onboarding.GetIsFinished().request()!)

        PersistedDataHolder.onboardingFinished = false
        XCTAssertFalse(Repos.Onboarding.GetIsFinished().request()!)
    }

    func testSetIsFinished() {
        XCTAssertFalse(PersistedDataHolder.onboardingFinished)

        Repos.Onboarding.SetIsFinished().request(parameters: true)
        XCTAssertTrue(PersistedDataHolder.onboardingFinished)

        Repos.Onboarding.SetIsFinished().request(parameters: false)
        XCTAssertFalse(PersistedDataHolder.onboardingFinished)
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
