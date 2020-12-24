//
//  CryptocurrencyDecoderTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class CryptocurrencyDecoderTests: XCTestCase {
    private var sut: DefaultJSONDecoder<CryptocurrencyList>!
    private let fixtures = Fixtures()
    
    override func setUp() {
        sut = DefaultJSONDecoder<CryptocurrencyList>()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    /**
     *  When: JSONData in a correct format is passed for parsing
     *   Then:   No exceptions are raised
     *    And:   Data is parsed correctly into model files
     */
    func testParsingValidJSON() {
        guard let jsonData = fixtures.cryptocurrencyJSONData else {
             XCTFail("incorrect fixture")
             return
        }
        
        var result: CryptocurrencyList?
        
        XCTAssertNoThrow(result = try sut.decode(data: jsonData))
        XCTAssertEqual(result?.cryptocurrencies.count, 3)
        
        let expectedLast = Cryptocurrency(name: "Ethereum",
                                          shortName: "ETH",
                                          priceUSD: 608.92,
                                          sevenDaysChangePercent: -2.74)
        XCTAssertEqual(result?.cryptocurrencies.last, expectedLast)
    }
}
