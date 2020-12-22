//
//  DIContainer.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

protocol DIContainerProtocol {
    var httpClient: HttpClient { get }
    var analyticsProvider: AnalyticsStatsEndpointProvider { get }
    var fruitsDataProvider: FruitsDataProvider { get }
}

struct DIContainer: DIContainerProtocol {
    let httpClient: HttpClient
    let analyticsProvider: AnalyticsStatsEndpointProvider
    let fruitsDataProvider: FruitsDataProvider
    
    init() {
        let requestSender = DefaultRequestSender()
        
        httpClient = DefaultHttpClient(requestSender: requestSender)
        analyticsProvider = AnalyticsStatsEndpointProvider(httpClient: httpClient)
        fruitsDataProvider = DefaultFruitsDataProvider(httpClient: httpClient,
                                                       analyticsProvider: analyticsProvider)
    }
}
