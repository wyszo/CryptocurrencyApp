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
    
    private var debugLog: DebugLogAnalyticsProvider?
    private var firebase: FirebaseAnalyticsProvider?
    
    private var enabledProviders = [AnalyticsProviderProtocol]()
    
    init(enabledDebugLog: Bool,
         enableFirebase: Bool) {
        
        if enabledDebugLog {
            let debugLog = resolver.resolve(DebugLogAnalyticsProvider.self)
            enabledProviders.append(debugLog)
            self.debugLog = debugLog
        }
        if enableFirebase {
            let firebase = resolver.resolve(FirebaseAnalyticsProvider.self)
            enabledProviders.append(firebase)
            self.firebase = firebase
        }
    }
    
    func cryptocurrencyListItemSelected(_ crypto: Cryptocurrency) {
        enabledProviders.forEach {
            $0.cryptocurrencyListItemSelected(crypto)
        }
    }
}
