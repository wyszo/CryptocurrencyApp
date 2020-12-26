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
        assertionFailure("Not implemented yet!")
        return Promise(error: CryptocurrencyListError.notImplementedYet)
    }
}

enum CryptocurrencyListError: Error {
    case notImplementedYet
}
