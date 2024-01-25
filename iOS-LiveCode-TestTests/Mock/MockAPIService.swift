//
//  MockAPIService.swift
//  iOS-LiveCode-TestTests
//
//  Created by Abin Baby on 25.01.24.
//

import Foundation
@testable import iOS_LiveCode_Test

class MockAPIService: Service {
    func getAddresses() async throws -> [Address] {
        let testAddresses: [Address] = TestUtilities.load(
            fromJSON: "address",
            type: [Address].self
        )
        return testAddresses
    }
}

