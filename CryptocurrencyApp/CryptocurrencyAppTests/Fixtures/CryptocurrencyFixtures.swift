//
//  CryptocurrencyFixtures.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation
@testable import CryptocurrencyApp

class CryptocurrencyFixtures {
    var bitcoin: Cryptocurrency {
        return Cryptocurrency(name: "Bitcoin",
                              shortName: "BTC",
                              priceUSD: 23574.77,
                              changePercent7d: 14.40)
    }

    var litecoin: Cryptocurrency {
        return Cryptocurrency(name: "Litecoin",
                              shortName: "LTC",
                              priceUSD: 105.03,
                              changePercent7d: -5.13)
    }
    
    var ethereum: Cryptocurrency {
        return Cryptocurrency(name: "Ethereum",
                              shortName: "ETH",
                              priceUSD: 608.92,
                              changePercent7d: -2.74)
    }
    
    var defaultList: CryptocurrencyList {
        return CryptocurrencyList(cryptocurrencies: [
            bitcoin,
            litecoin,
            ethereum
        ], marketCapBilionsUSD: 641.02)
    }
}
