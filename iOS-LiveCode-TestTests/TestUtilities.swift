//
//  TestUtilities.swift
//  iOS-LiveCode-Test
//
//  Created by Abin Baby on 24.01.24.
//

import Foundation

class TestUtilities {
    static func load<T: Decodable>(fromJSON fileName: String, type: T.Type) -> T {
        guard let url = Bundle(for: TestUtilities.self).url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(fileName).json from test bundle.")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Failed to decode \(fileName).json: \(error)")
        }
    }
}
