//
//  Fixtures.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class Fixtures {
    
    var apple: Fruit {
        return Fruit(type: "Apple",
                     priceInPence: 999,
                     weightInGrams: 250)
    }
    
    var boxedFruitsOneApple: BoxedFruit {
        return BoxedFruit(fruit: [apple])
    }
    
    var boxedFruitsEmpty: BoxedFruit {
        return BoxedFruit(fruit: [])
    }
    
    var fruitsJSONData: Data? {
        return JSONData(fromFile: "Fruits")
    }
    
    var cryptocurrencyJSONData: Data? {
        return JSONData(fromFile: "Cryptocurrencies")
    }
    
    var malformedFruitsJSONData: Data? {
        return JSONData(fromFile: "MalformedFruits")
    }
    
    private func JSONData(fromFile filename: String) -> Data? {
        
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            XCTFail("invalid fixture filename")
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("invalid json file")
            return nil
        }
        return data
    }
}
