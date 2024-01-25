//
//  FetchAddressUseCase.swift
//  iOS-LiveCode-Test
//
//  Created by Abin Baby on 25.01.24.
//

import Foundation

final class FetchAddressesUseCase {
    private let apiService: Service
    private let addressValidatorUseCase: AddressValidatorUseCase

    init(
        apiService: Service = APIService(),
        addressValidatorUseCase: AddressValidatorUseCase = AddressValidatorUseCase()
    ) {
        self.apiService = apiService
        self.addressValidatorUseCase = addressValidatorUseCase
    }

    func execute() async throws -> [AddressType: [Address]] {
        do {
            let fetchedAddresses = try await apiService.getAddresses()
            return categorizeAddresses(fetchedAddresses)
        } catch {
            throw error
        }
    }

    private func categorizeAddresses(_ addresses: [Address]) -> [AddressType: [Address]] {
        var categorizedAddresses: [AddressType: [Address]] = [:]

        for address in addresses {
            if addressValidatorUseCase.execute(address) {
                let type = address.addressType
                categorizedAddresses[type, default: []].append(address)
            }
        }

        return categorizedAddresses
    }
}

