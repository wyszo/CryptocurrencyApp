//
//  DebugLogAnalyticsProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

class DebugLogAnalyticsProvider: AnalyticsProviderProtocol {
    func cryptocurrencyListItemSelected(_ crypto: Cryptocurrency) {
        // TODO: print only in debug mode
        print("") // maybe print method name here (and the object name)
        
        assertionFailure("Not implemented yet")
    }
}
