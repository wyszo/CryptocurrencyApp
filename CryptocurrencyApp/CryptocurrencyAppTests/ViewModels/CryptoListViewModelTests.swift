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

    func testFetchSuccessThenItemAtIndexFromCache() {
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
    
    func testFetchFailure() {
        // Given: Data provider getCryptocurrencies stubbed with an error
        let stubbedError = MockedError.genericError
        let promise = Promise<CryptocurrencyList>.init(error: stubbedError)
        Given(cryptoDataProvider, .getCryptocurrencies(willReturn: promise))
        
        // And: Fetch executed and completed
        let fetch = sut.fetch()
        var capturedList: CryptocurrencyList?
        var capturedError: Error?
        waitFor(promise: fetch,
                value: &capturedList,
                error: &capturedError)
        
        // Then: It should return an error
        XCTAssertEqual(capturedError as? MockedError, stubbedError)
    }

    func testFetchSuccessThenFailureDoesNotClearCache() {
        // Given: Data provider getCryptocurrencies stubbed with success
        let list = cryptoFixtures.defaultList
        let promiseOne = Promise<CryptocurrencyList>.value(list)
        Given(cryptoDataProvider, .getCryptocurrencies(willReturn: promiseOne))

        // And: Fetch executed and completed
        let fetchOne = sut.fetch()
        waitFor(promise: fetchOne)
        
        // And: Data provider getCryptocurrencies stubbed with an error
        let stubbedError = MockedError.genericError
        let promiseTwo = Promise<CryptocurrencyList>.init(error: stubbedError)
        Given(cryptoDataProvider, .getCryptocurrencies(willReturn: promiseTwo))

        // And: Another fetch executed and completed
        let fetchTwo = sut.fetch()
        waitFor(promise: fetchTwo)
        
        // When: itemAtIndex(0) called
        let item = sut.itemAtIndex(0)
        
        // Then: It should return cached correct item
        XCTAssertEqual(item, cryptoFixtures.bitcoin)
    }

    func testItemSelectedAnalytics() {
        // When: list item pressed
        let crypto = cryptoFixtures.bitcoin
        sut.itemSelected(cryptocurrency: crypto)
        
        // Then: analytics event should be send
        Verify(analyticsProvider, 1, .cryptocurrencyListItemSelected())
    }
}
