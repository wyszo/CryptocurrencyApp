//
//  FruitDetailsViewModel.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

class FruitDetailViewModel {
    private let currenctyFormatter = CurrencyFormatter()
    private let weightFormatter = WeightFormatter()
    private let fruit: Fruit
    
    init(fruit: Fruit) {
        self.fruit = fruit
    }
    
    var type: String {
        return fruit.type
    }
    
    var price: String {
        return currenctyFormatter.toPounds(pence: fruit.priceInPence)
    }
    
    var weight: String {
        return weightFormatter.toKg(grams: fruit.weightInGrams)
    }
}

fileprivate struct CurrencyFormatter {
    private let formatter = NumberFormatter()
    
    init() {
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_GB")
    }
    
    func toPounds(pence: UInt) -> String {
        let pounds = Double(pence) * 0.01
        return formatter.string(from: NSNumber(value: pounds)) ?? ""
    }
}

fileprivate struct WeightFormatter {
    func toKg(grams: UInt) -> String {
        let weightInKg = Double(grams) * 0.001
        return String(format: "%.1f", weightInKg) + " kg"
    }
}
