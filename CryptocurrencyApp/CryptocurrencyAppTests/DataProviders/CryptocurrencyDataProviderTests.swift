//
//  CryptocurrencyDataProviderTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
import SwiftyMocky
import PromiseKit
@testable import CryptocurrencyApp

import Resolver

class TestDependenciesResolver: Resolving {
    
    init() {
        resolver.register(HttpClient.self) {
            return HttpClientMock()
        }
    }
}

class CryptocurrencyDataProviderTests: XCTestCase, Resolving {
    private var sut: CryptocurrencyDataProvider!
    private let fixtures = Fixtures()
    private let dependenciesResolver = TestDependenciesResolver()
    private var httpClient: HttpClientMock!
    
    override func setUp() {
        httpClient = (resolver.optional(HttpClient.self) as! HttpClientMock)
        sut = CryptocurrencyDataProvider()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    /**
     *  When: getCryptocurrencies method is called
     *  Then: correct http network request is made
     *  And:  returned promise completes
     *  And:  it should return correct value
     */
    func testRequest() {
        let testBundle = Bundle(for: type(of: self))
        let url = testBundle.url(forResource: "Cryptocurrencies",
                                 withExtension: "json")!
        let stubbedData = try! Data(contentsOf: url)
        let stubbedPromise = Promise.value(stubbedData)
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        let result = sut.getCryptocurrencies()
        
        XCTFail("Not implemented yet!")
    }
    
    /**
     *  Given: getCryptocurrencies request is made
     *  When:  server returns json with an empty list
     *  Then:  getCryptocurrencies returns an empty array
     */
    func testSuccessEmptyResponse() {
        let stubbedList = CryptocurrencyList(cryptocurrencies: [],
                                             marketCapBilionsUSD: 0)
        let stubbedPromise = Promise.value(stubbedList)
        
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
