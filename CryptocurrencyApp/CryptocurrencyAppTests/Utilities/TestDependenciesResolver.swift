//
//  TestDependenciesResolver.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Resolver
@testable import CryptocurrencyApp

class TestDependenciesResolver: Resolving {
    
    init() {
        resetState()
    }
    
    func resetState() {
        Resolver.reset()
        Resolver.defaultScope = Resolver.cached
        registerMocks()
    }
    
    private func registerMocks() {
        resolver.register(RouterProtocol.self) {
            return RouterProtocolMock()
        }
        resolver.register(HttpClient.self) {
            return HttpClientMock()
        }
        resolver.register(AnalyticsProviderProtocol.self) {
            return AnalyticsProviderProtocolMock()
        }
        resolver.register(CryptoDataProviderProtocol.self) {
            return CryptoDataProviderProtocolMock()
        }
    }
    
    func resolveHttpClientMock() -> HttpClientMock {
        return resolver.optional(HttpClient.self) as! HttpClientMock
    }
    
    func resolveAnalyticsProviderMock() -> AnalyticsProviderProtocolMock {
        return resolver.optional(AnalyticsProviderProtocol.self) as! AnalyticsProviderProtocolMock
    }
    
    func resolveCryptoDataProviderProtocolMock() -> CryptoDataProviderProtocolMock {
        return resolver.optional(CryptoDataProviderProtocol.self) as! CryptoDataProviderProtocolMock
    }
}
