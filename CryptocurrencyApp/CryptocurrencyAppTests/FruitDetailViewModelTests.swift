//
//  FruitDetailViewModelTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class FruitDetailViewModelTests: XCTestCase {
    
    private var sut: FruitDetailViewModel!

    override func tearDown() {
        sut = nil
    }
    
    func testPriceAndWeightFormattingNonZero() {
        let fruit = Fruit(type: "onion", priceInPence: 434, weightInGrams: 534)
        
        sut = FruitDetailViewModel(fruit: fruit)
        
        XCTAssertEqual(sut.type, "onion")
        XCTAssertEqual(sut.price, "£4.34")
        XCTAssertEqual(sut.weight, "0.5 kg")
    }
    
    func testFormattingWithZeros() {
        let fruit = Fruit(type: "", priceInPence: 0, weightInGrams: 0)
        
        sut = FruitDetailViewModel(fruit: fruit)

        XCTAssertEqual(sut.type, "")
        XCTAssertEqual(sut.price, "£0.00")
        XCTAssertEqual(sut.weight, "0.0 kg")
    }
}
