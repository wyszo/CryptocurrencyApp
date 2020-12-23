//
//  FruitJSONDecoderTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class FruitJSONDecoderTests: XCTestCase {
    private var sut: DefaultJSONDecoder<BoxedFruit>!
    private let fixtures = Fixtures()
    
    override func setUp() {
        sut = DefaultJSONDecoder<BoxedFruit>()
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
        guard let jsonData = fixtures.fruitsJSONData else {
            XCTFail("incorrect fixture")
            return
        }
        
        var result: BoxedFruit?
        
        XCTAssertNoThrow(result = try sut.decode(data: jsonData))
        XCTAssertEqual(result?.fruit.count, 9)
        
        let expectedLast = Fruit(type: "kiwi", priceInPence: 89, weightInGrams: 200)
        XCTAssertEqual(result?.fruit.last, expectedLast)
    }
}
