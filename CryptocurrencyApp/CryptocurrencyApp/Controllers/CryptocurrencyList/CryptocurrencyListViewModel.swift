//
//  CryptocurrencyListViewModel.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import Resolver
import PromiseKit

class CryptocurrencyListViewModel {
    var navbarTitle: String {
        return "Cryptocurrency List"
    }
    
    private var cryptocurrencyList: CryptocurrencyList?
    
    @Injected var dataProvider: CryptocurrencyDataProviderProtocol
    
    func fetch() -> Promise<CryptocurrencyList> {
        let promise = dataProvider.getCryptocurrencies()
        _ = promise.done { list in
            self.cryptocurrencyList = list
        }
        promise.catch { _ in
            self.cryptocurrencyList = nil
        }
        return promise
    }
    
    func itemAtIndex(_ index: Int) -> Cryptocurrency? {
        guard let currencies = cryptocurrencyList?.cryptocurrencies, index < currencies.count else {
            assertionFailure("index out of bounds")
            return nil
        }
        return currencies[index]
    }
}
