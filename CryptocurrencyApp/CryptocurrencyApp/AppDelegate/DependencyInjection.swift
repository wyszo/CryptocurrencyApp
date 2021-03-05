//
//  DependencyInjection.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Resolver

extension Resolver {
    static func registerDependencies() {
        register {
            AppInitialiser()
        }
        register(DIContainerProtocol.self) {
            DIContainer()
        }
        register(RouterProtocol.self) {
            Router(diContainer: resolve())
        }.scope(cached)

        registerAnalytics()
        registerNetworkingStack()
        registerViewModels()
        registerDataProviders()
    }
    
    private static func registerAnalytics() {
        register { return DebugLogAnalyticsProvider() }
        register { return FirebaseAnalyticsProvider() }
        
        register(AnalyticsProviderProtocol.self) {
            DefaultAnalyticsProvider(enabledDebugLog: true,
                                     enableFirebase: false)
        }.scope(cached)
    }
    
    private static func registerNetworkingStack() {
        register(URLRequestSender.self) {
            DefaultRequestSender()
        }.scope(unique)
        
        register(HttpClient.self) {
            DefaultHttpClient()
        }.scope(cached)
    }
    
    private static func registerViewModels() {
        register {
            CryptoListViewModel()
        }.scope(unique)
        
        register { (_, args) in
            CryptoDetailViewModel(cryptocurrency: args())
        }.scope(unique)
    }
    
    private static func registerDataProviders() {
        register(CryptoDataProviderProtocol.self) {
            CryptoDataProvider()
        }.scope(unique)
         
        /**
         * Mocked data provider - turned off now
         *
        register(CryptoDataProviderProtocol.self) {
            let cryptocurrencies: [Cryptocurrency] = [
                Cryptocurrency.ethereum()
            ]
            let list = CryptocurrencyList(cryptocurrencies: cryptocurrencies, marketCapBilionsUSD: 500)
            return CryptoStaticDataProvider(cryptocurrencyList: list)
        }
         */
    }
}

/**
 * Mocked data extension - deprecated
 *
private extension Cryptocurrency {
    static func ethereum() -> Cryptocurrency {
        return Cryptocurrency(name: "Ethereum",
                              shortName: "ETH",
                              priceUSD: 608.92,
                              changePercent7d: -2.74)
    }
}
*/
