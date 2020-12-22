//
//  Fruit.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

struct Fruit: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case type
        case priceInPence = "price"
        case weightInGrams = "weight"
    }
    
    let type: String
    let priceInPence: UInt
    let weightInGrams: UInt
}

struct BoxedFruit: Codable, Equatable {
    let fruit: [Fruit]
}
