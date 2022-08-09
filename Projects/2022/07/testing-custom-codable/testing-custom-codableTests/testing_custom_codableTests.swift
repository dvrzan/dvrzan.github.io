//
//  testing_custom_codableTests.swift
//  testing-custom-codableTests
//
//  Created by Danijela Vrzan on 2022-06-08.
//

import XCTest
import Difference
@testable import testing_custom_codable

class testing_custom_codableTests: XCTestCase {

    func test_customDecoding_returnsExpectedValue() {
        //Given
        let conference = Seed.conference

        //When
        let decodedConference = try? JSONDecoder().decode(Conference.self, from: conferenceData)

        //Then
        XCTAssertEqual(decodedConference, conference)
    }







    public func XCTAssertEqual<T: Equatable>(_ expected: @autoclosure () throws -> T, _ received: @autoclosure () throws -> T, file: StaticString = #filePath, line: UInt = #line) {
        do {
            let expected = try expected()
            let received = try received()
            XCTAssertTrue(expected == received, "Found difference for \n" + diff(expected, received).joined(separator: ", "), file: file, line: line)
        }
        catch {
            XCTFail("Caught error while testing: \(error)", file: file, line: line)
        }
    }

}

private let conferenceData = Data("""
{
    "name": "iOSDevUK",
    "city": "Aberystwyth",
    "country": "United Kingdom",
    "date": "04/09/2027",
    "days": 4
}
""".utf8)

struct Seed {
    static let conference = Conference(
}
