//
//  FetchAddressesUseCaseTests.swift
//  iOS-LiveCode-TestTests
//
//  Created by Abin Baby on 25.01.24.
//

import XCTest
@testable import iOS_LiveCode_Test

class FetchAddressesUseCaseTests: XCTestCase {
    var mockAPIService: MockAPIService!
    var addressValidatorUseCase: AddressValidatorUseCase!
    var fetchAddressesUseCase: FetchAddressesUseCase!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        addressValidatorUseCase = AddressValidatorUseCase()
        fetchAddressesUseCase = FetchAddressesUseCase(
            apiService: mockAPIService,
            addressValidatorUseCase: addressValidatorUseCase
        )
    }

    override func tearDown() {
        fetchAddressesUseCase = nil
        mockAPIService = nil
        addressValidatorUseCase = nil
        super.tearDown()
    }

    func testFetchAddressesSuccess() async {

        do {
            // Setup
            let testAddresses = try await fetchAddressesUseCase.execute()

            // Execution
            let validResultAddressCount = 4

            // TODO: add test to verify different properties

            // Verification
            XCTAssertEqual(validResultAddressCount, testAddresses.count)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    // Add more tests for different scenarios like failure, error, empty list
}

