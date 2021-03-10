//
//  Fixtures.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class Fixtures {
    
    var cryptocurrencyJSONData: Data? {
        return JSONData(fromFile: "Cryptocurrencies")
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
