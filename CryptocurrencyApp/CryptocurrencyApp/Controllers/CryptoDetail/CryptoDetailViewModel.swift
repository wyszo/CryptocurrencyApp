//
//  CryptoDetailViewModel.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import Resolver

class CryptoDetailViewModel {
    private let cryptocurrency: Cryptocurrency

    @Injected private var analyticsProvider: AnalyticsProviderProtocol
    
    var name: String {
        return cryptocurrency.name
    }
    
    var shortName: String {
        return cryptocurrency.shortName
    }
    
    var priceUSD: String {
        return String(format: "%.02f", cryptocurrency.priceUSD)
    }
    
    var changePercent7d: String {
        return String(format: "%.02f", cryptocurrency.changePercent7d)
    }
    
    init(cryptocurrency: Cryptocurrency) {
        self.cryptocurrency = cryptocurrency
    }
    
    func attachedToView() {
        analyticsProvider.screenView(.cryptocurrencyDetail)
    }
}
