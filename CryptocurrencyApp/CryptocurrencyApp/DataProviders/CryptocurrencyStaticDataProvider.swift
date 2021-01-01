//
//  CryptocurrencyStaticDataProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import PromiseKit

/**
 * Temporary class returning the cryptocurrency list it was created with (mock)
 */
class CryptocurrencyStaticDataProvider: CryptocurrencyDataProviderProtocol {
    
    private let cryptocurrencyList: CryptocurrencyList
    
    init(cryptocurrencyList: CryptocurrencyList) {
        self.cryptocurrencyList = cryptocurrencyList
    }
    
    func getCryptocurrencies() -> Promise<CryptocurrencyList> {
        Promise.value(cryptocurrencyList)
    }
}
