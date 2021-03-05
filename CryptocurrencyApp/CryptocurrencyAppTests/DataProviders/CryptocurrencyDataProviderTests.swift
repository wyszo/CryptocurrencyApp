//
//  CryptoDataProviderTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
import SwiftyMocky
import PromiseKit
@testable import CryptocurrencyApp

class CryptoDataProviderTests: XCTestCase {
    private var sut: CryptoDataProvider!
    private let fixtures = Fixtures()
    private let fileReader = FileReader()
    private let dependenciesResolver = TestDependenciesResolver()
    private var httpClient: HttpClientMock!
    
    override func setUp() {
        super.setUp()
        dependenciesResolver.resetState()
        httpClient = dependenciesResolver.resolveHttpClientMock()
        sut = CryptoDataProvider()
    }
    
    func testRequestSend() {
        // Given: network communication stubbed
        let stubbedPromise = fileReader.promiseFromFile("Cryptocurrencies.json")
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        // When: getCryptocurrencies method is called
        let result = sut.getCryptocurrencies()
        waitFor(promise: result)
        waitFor(promise: stubbedPromise)
        
        // Then: correct network request is made
        Verify(httpClient, 1, .sendRequest(metadata: .any))

        let expectedRequest = RequestMetadata(type: .get,
                                              apiPath: "Cryptocurrencies.json",
                                              apiHost: "https://storage-cryptocurrency-app-dev.s3-eu-west-1.amazonaws.com/")
        Verify(httpClient, 1, .sendRequest(metadata: .value(expectedRequest)))
    }
    
    func testRequestParsesResultCorrectly() {
        // Given: network communication stubbed and returning valid data
        let stubbedPromise = fileReader.promiseFromFile("Cryptocurrencies.json")
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        // When: getCryptocurrencies method is called
        let result = sut.getCryptocurrencies()
        
        var capturedList: CryptocurrencyList?
        var capturedError: Error?
        waitFor(promise: result,
                value: &capturedList,
                error: &capturedError)
        
        // Then: it should return a valid and correct cryptocurrencies list
        let expectedList = CryptocurrencyFixtures().defaultList
        XCTAssertEqual(capturedList, expectedList)
        XCTAssertNil(capturedError)
    }
    
    /**
     * When: getCryptocurrencies method is called
     * Then: analytics call should be made
     */
    func testRequestAnalytics() {
        XCTFail("Not implemented yet")
    }
    
    /**
     *  Given: getCryptocurrencies request is made
     *  When:  server returns json with an empty list
     *  Then:  getCryptocurrencies returns an empty array
     */
    func testSuccessEmptyResponse() {
        // Given: network communication stubbed and returning valid data
        let stubbedPromise = fileReader.promiseFromFile("CryptocurrenciesEmpty.json")
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        // When: getCryptocurrencies method is called
        let result = sut.getCryptocurrencies()
        
        var capturedList: CryptocurrencyList?
        var capturedError: Error?
        waitFor(promise: result,
                value: &capturedList,
                error: &capturedError)
        
        // Then: it should return a valid empty cryptocurrencies list
        let expectedList = CryptocurrencyFixtures().emptyList
        XCTAssertEqual(capturedList, expectedList)
        XCTAssertNil(capturedError)
    }

    func testReceivedMalformedJson() {
        // Given: network communication stubbed and returning valid data
        let stubbedPromise = fileReader.promiseFromFile("CryptocurrenciesMalformed.json")
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        // When: getCryptocurrencies method is called
        let result = sut.getCryptocurrencies()
        var capturedList: CryptocurrencyList?
        var capturedError: Error?
        waitFor(promise: result,
                value: &capturedList,
                error: &capturedError)
        
        // And: it should return a decoding error
        XCTAssertNil(capturedList)
        XCTAssertNotNil(capturedError)
        XCTAssert(capturedError is DecodingError)
    }
    
    func testNetworkRequestError() {
        // Given: network communication stubbed and returning an error
        let errorToReturn = MockedError.genericError
        let stubbedPromise = Promise<Data>(error: errorToReturn)
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        // When: getCryptocurrencies method is called
        let result = sut.getCryptocurrencies()
        
        var capturedList: CryptocurrencyList?
        var capturedError: Error?
        waitFor(promise: result,
                value: &capturedList,
                error: &capturedError)

        // Then: it should return the stubbed error
        XCTAssertNil(capturedList)
        XCTAssertNotNil(capturedError)
        XCTAssertEqual(capturedError as? MockedError, errorToReturn)
    }
    
    /**
     *  Given: getCryptocurrencies call is made
     *  And:   getCryptocurrencies request has not completed yet
     *  And:   getCryptocurrencies is called again
     *  When:  the request succeeds
     *  Then:  both calls return correct value
     */
    func testTwoSubsequentRequestsReturnCorrectSuccessValues() {
        
        // Given: network communication stubbed and returning valid data
        let stubbedPromise = fileReader.promiseFromFile("Cryptocurrencies.json")
        
        Given(httpClient, .sendRequest(metadata: .any,
                                       willReturn: stubbedPromise))
        
        // And: getCryptocurrencies has been called but has not finished yet
        let resultOne = sut.getCryptocurrencies()
        var capturedListOne: CryptocurrencyList?
        var capturedErrorOne: Error?
        
        // And: another getCryptocurrencies call was made but has not finished
        let resultTwo = sut.getCryptocurrencies()
        var capturedListTwo: CryptocurrencyList?
        var capturedErrorTwo: Error?
        
        // When: the requests succeed
        waitFor(promise: resultOne,
                value: &capturedListOne,
                error: &capturedErrorOne)
        waitFor(promise: resultTwo,
                value: &capturedListTwo,
                error: &capturedErrorTwo)
        
        // Then: both calls return correct values
        let expectedList = CryptocurrencyFixtures().defaultList
        XCTAssertEqual(capturedListOne, expectedList)
        XCTAssertNil(capturedErrorOne)
        XCTAssertEqual(capturedListTwo, expectedList)
        XCTAssertNil(capturedErrorTwo)
    }
}
