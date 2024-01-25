//
//  AddressValidatorUseCase.swift
//  iOS-LiveCode-Test
//
//  Created by Abin Baby on 24.01.24.
//

import Foundation

final class AddressValidatorUseCase {

    func execute(_ address: Address) -> Bool {
        // Check for valid postcode first
        guard 
            isValidPostcode(address.postcode, addressType: address.addressType)
        else {
            return false
        }

        // Check for required properties based on the country
        return isValidAddressBasedOnCountry(address)
    }

    private func isValidAddressBasedOnCountry(_ address: Address) -> Bool {
        switch address.addressType {
        case .uk:
            return isUKAddressValid(address)
        case .us, .canada:
            return isUSOrCanadaAddressValid(address)
        default:
            return isInternationalAddressValid(address)
        }
    }
}

private extension AddressValidatorUseCase {

    func isValidPostcode(_ postcode: String?, addressType: AddressType) -> Bool {
        let regex: String
        switch addressType {
        case .uk:
            regex = "^[A-Za-z][A-Ha-hJ-Yj-y]?[0-9][A-Za-z0-9]? ?[0-9][A-Za-z]{2}$"
        case .us:
            regex = "^[0-9]{5}(?:-[0-9]{4})?$"
        case .canada:
            regex = "^(?!.*[DFIOQU])[A-VXY][0-9][A-Z] ?[0-9][A-Z][0-9]$"
        default:
            return true
        }
        
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: postcode)
    }

    func isUKAddressValid(_ address: Address) -> Bool {
        return !address.street.isEmpty && !address.town.isEmpty && address.postcode != nil && !address.countryCode.isEmpty
    }

    func isUSOrCanadaAddressValid(_ address: Address) -> Bool {
        return !address.street.isEmpty && !address.town.isEmpty && address.state != nil && address.postcode != nil && !address.countryCode.isEmpty
    }

    func isInternationalAddressValid(_ address: Address) -> Bool {
        return !address.street.isEmpty && !address.town.isEmpty && !address.countryCode.isEmpty
    }
}
