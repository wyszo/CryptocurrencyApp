//
//  CryptocurrencyStaticDataProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import PromiseKit

/**
 * A temporary class returning the cryptocurrency list it was created with 
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
