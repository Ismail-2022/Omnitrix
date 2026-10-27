import XCTest
@testable import Omnitrix

final class AlienRosterTests: XCTestCase {

    func testRosterHasAllNineteenOriginalAliens() {
        XCTAssertEqual(AlienRoster.all.count, 19)
        XCTAssertEqual(AlienRoster.all.first?.name, "Heatblast")
        XCTAssertEqual(AlienRoster.all.last?.name, "Way Big")
    }

    func testIdsMatchScrollOrder() {
        XCTAssertEqual(AlienRoster.all.map(\.id), Array(0..<19))
    }

    func testNamesAreUnique() {
        let names = AlienRoster.all.map(\.name)
        XCTAssertEqual(Set(names).count, names.count)
    }

    func testEveryAlienHasCoreFields() {
        for alien in AlienRoster.all {
            XCTAssertFalse(alien.species.isEmpty, "\(alien.name) missing species")
            XCTAssertFalse(alien.power.isEmpty, "\(alien.name) missing power")
            XCTAssertFalse(alien.symbol.isEmpty, "\(alien.name) missing symbol")
        }
    }

    func testCrownValueMapsToIndex() {
        XCTAssertEqual(AlienRoster.index(forCrownValue: 0), 0)
        XCTAssertEqual(AlienRoster.index(forCrownValue: 4.4), 4)
        XCTAssertEqual(AlienRoster.index(forCrownValue: 4.6), 5)
        XCTAssertEqual(AlienRoster.index(forCrownValue: 18), 18)
    }

    func testCrownValueWrapsAroundBothWays() {
        XCTAssertEqual(AlienRoster.index(forCrownValue: 19), 0)
        XCTAssertEqual(AlienRoster.index(forCrownValue: 20), 1)
        XCTAssertEqual(AlienRoster.index(forCrownValue: -1), 18)
        XCTAssertEqual(AlienRoster.index(forCrownValue: -20), 18)
    }
}
