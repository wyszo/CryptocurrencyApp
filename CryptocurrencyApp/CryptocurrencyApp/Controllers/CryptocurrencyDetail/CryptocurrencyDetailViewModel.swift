//
//  CryptocurrencyDetailViewModel.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

class CryptocurrencyDetailViewModel {
    private let cryptocurrency: Cryptocurrency
    
    init(cryptocurrency: Cryptocurrency) {
        self.cryptocurrency = cryptocurrency
    }
}
