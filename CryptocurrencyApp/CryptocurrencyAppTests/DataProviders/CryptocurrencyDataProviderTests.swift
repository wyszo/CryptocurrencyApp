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

class CryptocurrencyDataProviderTests: XCTestCase {
    private var sut: CryptocurrencyDataProvider!
    private let fixtures = Fixtures()
    private let fileReader = FileReader()
    private let dependenciesResolver = TestDependenciesResolver()
    private var httpClient: HttpClientMock!
    
    override func setUp() {
        httpClient = dependenciesResolver.resolveHttpClientMock()
        sut = CryptocurrencyDataProvider()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testRequestSend() {
        // Given: network communication stubbed
        let stubbedPromise = fileReader.promiseFromFile("Cryptocurrencies.json")
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        // When: getCryptocurrencies method is called
        let result = sut.getCryptocurrencies()
        waitFor(promise: result)
        
        // Then: correct network request is made
        Verify(httpClient, 1, .sendRequest(metadata: .any))

        let expectedRequest = RequestMetadata(type: .get,
                                              apiPath: "Cryptocurrencies.json",
                                              apiHost: "https://storage-cryptocurrency-app-dev.s3-eu-west-1.amazonaws.com/")
        Verify(httpClient, 1, .sendRequest(metadata: .value(expectedRequest)))
    }
    
    func testRequestParsesResult() {
        // Given: network communication stubbed and returning valid data
        let stubbedPromise = fileReader.promiseFromFile("Cryptocurrencies.json")
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        // When: getCryptocurrencies method is called
        let result = sut.getCryptocurrencies()
        
        var capturedList: CryptocurrencyList?
        var capturedError: Error?
        waitFor(promise: result, value: &capturedList, error: &capturedError)
        
        // Then: it should return a valid and correct cryptocurrencies list
        let expectedList = CryptocurrencyFixtures().defaultList
        XCTAssertEqual(capturedList, expectedList)
        XCTAssertNil(capturedError)
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
