//
//  TestDependencyResolver.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Resolver
@testable import CryptocurrencyApp

class TestDependencyResolver: Resolving {
    
    init() {
        resetState()
    }
    
    func resetState() {
        Resolver.reset()
        recreateMocks()
        registerMocks()
    }
    
    private(set) var httpClientMock: HttpClientMock!
    private(set) var analyticsProviderMock: AnalyticsProviderProtocolMock!
    private(set) var cryptoDataProviderMock: CryptoDataProviderProtocolMock!
    private(set) var requestSenderMock: URLRequestSenderProtocolMock!
    
    private func recreateMocks() {
        httpClientMock = HttpClientMock()
        analyticsProviderMock = AnalyticsProviderProtocolMock()
        cryptoDataProviderMock = CryptoDataProviderProtocolMock()
        requestSenderMock = URLRequestSenderProtocolMock()
    }
    
    private func registerMocks() {
        resolver.register(RouterProtocol.self) {
            return RouterProtocolMock()
        }
        resolver.register(HttpClient.self) {
            return self.httpClientMock
        }
        resolver.register(AnalyticsProviderProtocol.self) {
            return self.analyticsProviderMock
        }
        resolver.register(CryptoDataProviderProtocol.self) {
            return self.cryptoDataProviderMock
        }
        resolver.register(URLRequestSenderProtocol.self) {
            return self.requestSenderMock
        }
    }
}
