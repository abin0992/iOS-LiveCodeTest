//
//  Address.swift
//  iOS-LiveCode-Test
//
//  Created by Abin Baby on 24.01.24.
//

import Foundation

struct Address: Codable, Identifiable {
    let id = UUID()
    var flatNumber: String?
    var buildingName: String?
    var street: String
    var town: String
    var state: String?
    var postcode: String?
    var countryCode: String
}

extension Address {
    var addressType: AddressType {
        switch countryCode {
        case "GBR": return .uk
        case "USA": return .us
        case "CAN": return .canada
        default: return .international
        }
    }

    var displayableAddress: String {
        var parts: [String] = []

        if let flatNumber = self.flatNumber {
            parts.append(String(flatNumber))
        }
        if let buildingName = self.buildingName {
            parts.append(buildingName)
        }

        parts.append(street)
        parts.append(town)

        if let state = self.state {
            parts.append(state)
        }
        if let postcode = self.postcode {
            parts.append(postcode)
        }

        parts.append(countryCode)

        return parts.joined(separator: ", ")
    }
}

enum AddressType {
    case uk, us, canada, international
}

extension AddressType: CaseIterable {
    var description: String {
        switch self {
        case .uk: return "United Kingdom 🇬🇧"
        case .us: return "United States 🇺🇸"
        case .canada: return "Canada 🇨🇦"
        case .international: return "International 🌍"
        }
    }
}
