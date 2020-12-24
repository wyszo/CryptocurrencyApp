//
//  CryptocurrencyDataProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import PromiseKit

protocol CryptocurrencyDataProviderProtocol {
    func getCryptocurrencies() -> Promise<CryptocurrencyList>
}

class CryptocurrencyDataProvider: CryptocurrencyDataProviderProtocol {
    
    func getCryptocurrencies() -> Promise<CryptocurrencyList> {
        assertionFailure("Not implemented yet!")
        let sampleList = CryptocurrencyList(cryptocurrencies: [],
                                            marketCapBilionsUSD: 0)
        return Promise.value(sampleList)
    }
}
