//
//  CryptocurrencyDataProviderTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
import SwiftyMocky
@testable import CryptocurrencyApp

class CryptocurrencyDataProviderTests: XCTestCase {
    private var sut: CryptocurrencyDataProvider!
    private let fixtures = Fixtures()
    
    override func setUp() {
        sut = CryptocurrencyDataProvider()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    /**
     *  When: getCryptocurrencies method is called
     *  Then: correct http network request is made
     *  And:  returned promise completes
     */
    func testRequest() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     *  Given: getCryptocurrencies request is made
     *  When:  server returns json with an empty list
     *  Then:  getCryptocurrencies returns an empty array
     */
    func testSuccessEmptyResponse() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     *  Given: getCryptocurrencies request is made
     *  When:  server returns json with an non-empty list
     *  Then:  getCryptocurrencies returns correct array
     */
    func testSuccessNonEmptyResponse() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     *  Given: getCryptocurrencies request is made
     *  When:  network request fails with an error
     *  Then:  getCryptocurrencies returns the error
     */
    func testNetworkRequestError() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     *  Given: getCryptocurrencies request is made
     *  When:  server returns malformed json
     *  Then:  getCryptocurrencies returns correct error
     */
    func testMalformedJsonReturned() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     *  When: getCryptocurrencies request is made
     *  Then: an analytics request is made
     */
    func testAnalytics() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     *  Given: getCryptocurrencies request is made
     *  And:   getCryptocurrencies request has not completed yet
     *  When:  getCryptocurrencies is called again
     *  Then:  Only one request should be made
     */
    func testTwoSubsequentCallsMakeOnlyOneRequest() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     *  Given: getCryptocurrencies call is made
     *  And:   getCryptocurrencies request has not completed yet
     *  And:   getCryptocurrencies is called again
     *  When:  the request succeeds
     *  Then:  both calls return correct value
     */
    func testTwoSubsequentRequestsReturnCorrectSuccessValues() {
        XCTFail("Not implemented yet!")
    }
}
