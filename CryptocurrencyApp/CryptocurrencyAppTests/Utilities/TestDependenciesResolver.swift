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
        Resolver.defaultScope = Resolver.unique
        registerMocks()
    }
    
    private func registerMocks() {
        resolver.register(HttpClient.self) {
            return HttpClientMock()
        }
    }
    
    func resolveHttpClientMock() -> HttpClientMock {
        return resolver.optional(HttpClient.self) as! HttpClientMock
    }
}
