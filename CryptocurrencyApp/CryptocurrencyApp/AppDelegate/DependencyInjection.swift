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

        registerNetworkingStack()
        registerViewModels()
        registerDataProviders()
    }
    
    private static func registerNetworkingStack() {
        register(URLRequestSender.self) {
            DefaultRequestSender()
        }.scope(unique)
    }
    
    private static func registerViewModels() {
        register {
            CryptocurrencyListViewModel()
        }.scope(unique)
        
        register { (_, args) in
            CryptocurrencyDetailViewModel(cryptocurrency: args())
        }.scope(unique)
    }
    
    private static func registerDataProviders() {
        // Real data provider - temporarily turned off
        /**
        register {
            CryptocurrencyDataProvider()
        }.scope(unique)
         */
        
        register(CryptocurrencyDataProviderProtocol.self) {
            let cryptocurrencies: [Cryptocurrency] = [
                Cryptocurrency.ethereum()
            ]
            let list = CryptocurrencyList(cryptocurrencies: cryptocurrencies, marketCapBilionsUSD: 500)
            return CryptocurrencyStaticDataProvider(cryptocurrencyList: list)
        }
    }
}

private extension Cryptocurrency {
    static func ethereum() -> Cryptocurrency {
        return Cryptocurrency(name: "Ethereum",
                              shortName: "ETH",
                              priceUSD: 608.92,
                              changePercent7d: -2.74)
    }
}
