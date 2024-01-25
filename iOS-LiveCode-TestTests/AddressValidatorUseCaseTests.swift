//
//  AddressValidatorUseCaseTests.swift
//  iOS-LiveCode-TestTests
//
//  Created by Abin Baby on 24.01.24.
//

import XCTest
@testable import iOS_LiveCode_Test

class AddressValidatorUseCaseTests: XCTestCase {

    var systemUnderTest: AddressValidatorUseCase!

    override func setUp() {
        super.setUp()
        systemUnderTest = AddressValidatorUseCase()
    }

    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }

    // Test postcode are taken from task documentation

    func testValidUKAddress() {
        let address = Address(flatNumber: nil, buildingName: nil, street: "Baker Street", town: "London", state: nil, postcode: "EC1N 2TD", countryCode: "GBR")
        XCTAssertTrue(systemUnderTest.execute(address))
    }

    func testInvalidUKAddressPostcode() {
        let address = Address(flatNumber: nil, buildingName: nil, street: "Baker Street", town: "London", state: nil, postcode: "1DF 444", countryCode: "GBR")
        XCTAssertFalse(systemUnderTest.execute(address))
    }

    func testValidUSAddress() {
        let address = Address(flatNumber: nil, buildingName: nil, street: "Fifth Avenue", town: "New York", state: "NY", postcode: "12345", countryCode: "USA")
        XCTAssertTrue(systemUnderTest.execute(address))
    }

    func testInvalidUSAddressEmptyPostCode() {
        let address = Address(flatNumber: nil, buildingName: nil, street: "Fifth Avenue", town: "New York", state: "NY", postcode: nil, countryCode: "USA")
        XCTAssertFalse(systemUnderTest.execute(address))
    }
    
    func testInvalidUSAddressPostCode() {
        let address = Address(flatNumber: nil, buildingName: nil, street: "Fifth Avenue", town: "New York", state: "NY", postcode: "ABCDE", countryCode: "USA")
        XCTAssertFalse(systemUnderTest.execute(address))
    }

}
