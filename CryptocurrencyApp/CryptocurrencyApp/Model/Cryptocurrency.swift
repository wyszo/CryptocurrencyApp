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
    
    let changePercent7d: Double
    
    var shortDescription: String {
        return name + " (" + shortName + ")"
    }
}

struct CryptocurrencyList: Codable, Equatable {
    let cryptocurrencies: [Cryptocurrency]
    let marketCapBilionsUSD: Double
}
