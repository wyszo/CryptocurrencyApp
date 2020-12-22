//
//  FruitListViewModel.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

class FruitListViewModel {
    typealias FruitsCallback = ([Fruit]) -> ()
    
    var navbarTitle: String {
        return "Fruit List"
    }
    
    var fruits: [Fruit] = [] {
        didSet {
            viewModelDidChange?(fruits)
        }
    }
    private let dataProvider: FruitsDataProvider
    
    // could use FRP bindings instead
    var viewModelDidChange: FruitsCallback?
    
    init(dataProvider: FruitsDataProvider) {
        self.dataProvider = dataProvider
    }
    
    func fetch() {
        dataProvider.getFruits { result in
            if case .success(let fruits) = result {
                self.fruits = fruits
            }
        }
    }
    
    func fruitAtIndex(_ index: Int) -> Fruit? {
        guard index < fruits.count else { return nil }
        return fruits[index]
    }
}
