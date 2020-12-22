//
//  JSONEncodable.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation
@testable import CryptocurrencyApp

protocol JSONEncodable: Encodable {
    func jsonData() -> Data?
}

extension JSONEncodable {
    func jsonData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}

extension BoxedFruit: JSONEncodable { }
