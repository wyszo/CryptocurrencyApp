//
//  CryptoListViewModelTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
import SwiftyMocky
import PromiseKit
@testable import CryptocurrencyApp

class CryptoListViewModelTests: XCTestCase {
    
    private var sut: CryptoListViewModel!
    private var analyticsProvider: AnalyticsProviderProtocolMock!
    private var cryptoDataProvider: CryptoDataProviderProtocolMock!
    private let dependenciesResolver = TestDependenciesResolver()
    private let cryptoFixtures = CryptocurrencyFixtures()
    
    override func setUp() {
        super.setUp()
        dependenciesResolver.resetState()
        
        analyticsProvider = dependenciesResolver.analyticsProviderMock
        cryptoDataProvider = dependenciesResolver.cryptoDataProviderMock
        sut = CryptoListViewModel()
    }

    /**
     * Given: fetch() method called
     * And:   fetch succeeded with at least 1 item
     * When:  itemAtIndex(0) called
     * Then:  it should return a correct item
     */
    func testFetchSuccessThenItemAtIndex() {
        
        // Given: Data provider getCryptocurrencies stubbed with success
        let list = cryptoFixtures.defaultList
        let promise = Promise<CryptocurrencyList>.value(list)
        Given(cryptoDataProvider, .getCryptocurrencies(willReturn: promise))
        
        // And: Fetch executed and completed
        let fetch = sut.fetch()
        waitFor(promise: fetch)
        
        // When: ItemAtIndex(0) called
        let item = sut.itemAtIndex(0)
        
        // Then: It should return correct item
        XCTAssertEqual(item, cryptoFixtures.bitcoin)
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

    func testItemSelectedAnalytics() {
        // When: list item pressed
        let crypto = cryptoFixtures.bitcoin
        sut.itemSelected(cryptocurrency: crypto)
        
        // Then: analytics event should be send
        Verify(analyticsProvider, 1, .cryptocurrencyListItemSelected())
    }
}
