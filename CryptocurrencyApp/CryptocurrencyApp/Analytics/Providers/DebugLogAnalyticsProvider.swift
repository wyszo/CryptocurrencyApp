//
//  DebugLogAnalyticsProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

class DebugLogAnalyticsProvider: AnalyticsProviderProtocol {
    func cryptocurrencyListItemSelected(_ crypto: Cryptocurrency) {
        logEvent(message: crypto.name)
    }
    
    private func logEvent(message: String = "", function: String = #function) {
        guard Environment.debug else {
            return
        }
        print("[Analytics]: \(function) \(message)")
    }
}
