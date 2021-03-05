//
//  DIContainer.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

protocol DIContainerProtocol {
    var httpClient: DeprecatedHttpClient { get }
    var analyticsProvider: DeprecatedAnalyticsStatsEndpointProvider { get }
    var fruitsDataProvider: FruitsDataProvider { get }
}

struct DIContainer: DIContainerProtocol {
    let httpClient: DeprecatedHttpClient
    let analyticsProvider: DeprecatedAnalyticsStatsEndpointProvider
    let fruitsDataProvider: FruitsDataProvider
    
    init() {
        let requestSender = DefaultDeprecatedRequestSender()
        
        httpClient = DefaultDeprecatedHttpClient(requestSender: requestSender)
        analyticsProvider = DeprecatedAnalyticsStatsEndpointProvider(httpClient: httpClient)
        fruitsDataProvider = DefaultFruitsDataProvider(httpClient: httpClient,
                                                       analyticsProvider: analyticsProvider)
    }
}
