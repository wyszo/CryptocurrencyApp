//
//  DefaultAnayticsProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import Resolver

/**
 * Default analytics implementation routing all analytics calls
 * to registered providers
 */
class DefaultAnalyticsProvider: AnalyticsProviderProtocol, Resolving {
    
    private var enabledProviders = [AnalyticsProviderProtocol]()
    
    init(providers: [AnalyticsProviderProtocol]) {
        self.enabledProviders = providers
    }
    
    func add(provider: AnalyticsProviderProtocol) {
        self.enabledProviders.append(provider)
    }
    
    func cryptocurrencyListItemSelected(_ crypto: Cryptocurrency) {
        enabledProviders.forEach {
            $0.cryptocurrencyListItemSelected(crypto)
        }
    }
}
