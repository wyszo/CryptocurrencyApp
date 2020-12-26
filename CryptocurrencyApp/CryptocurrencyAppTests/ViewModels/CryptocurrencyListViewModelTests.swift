//
//  CryptocurrencyListViewModelTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class CryptocurrencyListViewModelTests: XCTestCase {
    
    private var sut: CryptocurrencyListViewModel!

    override func tearDown() {
        sut = nil
    }

    /**
     * Given: fetch() method called
     * And:   fetch succeeded with at least 1 item
     * When:  itemAtIndex(0) called
     * Then:  it should return a correct item
     */
    func testFetchSuccessThenItemAtIndex() {
        XCTFail("Not implemented yet")
    }
    
    /**
     * Given: fetch() method called
     * And:   fetch succeeded with at least 1 item
     * And:   fetch() method called again
     * When:  fetch method failed
     * And:   itemAtIndex(0) called
     * Then:  it should return nil
     */
    func testFetchSuccessThenFailureClearsCache() {
        XCTFail("Not implemented yet")
    }
}
