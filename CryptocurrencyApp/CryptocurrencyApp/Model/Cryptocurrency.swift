//
//  Cryptocurrency.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

struct Cryptocurrency: Codable, Equatable {
    let name: String
    let shortName: String
    let priceUSD: Double
    let sevenDaysChangePercent: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case shortName
        case priceUSD
        case sevenDaysChangePercent = "7dChangePercent"
    }
    
    var shortDescription: String {
        return name + " (" + shortName + ")"
    }
}

struct CryptocurrencyList: Codable, Equatable {
    let cryptocurrencies: [Cryptocurrency]
    let marketCapBilionsUSD: Double
}
