//
//  CryptoListViewModel.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import Resolver
import PromiseKit

class CryptoListViewModel {
    var navbarTitle: String {
        return "Cryptocurrency List"
    }
    
    private var cryptocurrencyList: CryptocurrencyList?
    
    @Injected private var dataProvider: CryptoDataProviderProtocol
    @Injected private var analyticsProvider: AnalyticsProviderProtocol
    
    func attachedToView() {
        analyticsProvider.screenView(.cryptocurrencyList)
    }
    
    func fetch() -> Promise<CryptocurrencyList> {
        return Promise<CryptocurrencyList> { seal in
            let getCrypto = dataProvider.getCryptocurrencies()
            _ = getCrypto.done { list in
                self.cryptocurrencyList = list
                seal.fulfill(list)
            }
            getCrypto.catch { error in
                seal.reject(error)
            }
        }
    }
    
    func itemAtIndex(_ index: Int) -> Cryptocurrency? {
        guard let currencies = cryptocurrencyList?.cryptocurrencies, index < currencies.count else {
            assertionFailure("index out of bounds")
            return nil
        }
        return currencies[index]
    }
    
    func itemSelected(cryptocurrency: Cryptocurrency) {
        analyticsProvider.cryptocurrencyListItemSelected(cryptocurrency)
    }
}
