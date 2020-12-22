//
//  FruitsDataProviderTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class FruitsDataProviderTests: XCTestCase {
    
    private var sut: FruitsDataProvider!
    private let fixtures = Fixtures()
    private var mockHttpClient: MockHttpClient!
    private var mockAnalyticsProvider: MockAnalyticsProvider!
    
    override func setUp() {
        mockHttpClient = MockHttpClient()
        mockAnalyticsProvider = MockAnalyticsProvider()
        sut = DefaultFruitsDataProvider(httpClient: mockHttpClient,
                                        analyticsProvider: mockAnalyticsProvider)
    }
    
    override func tearDown() {
        mockHttpClient = nil
        mockAnalyticsProvider = nil
        sut = nil
    }
    
    /**
     *  When:   getFruits method is called
     *  Then:    correct http request is made
     *   And:    completion method is called
     */
    func testRequest() {
        var completionBlockCalled = false
        mockHttpClient.dataToReturn = Data()
        
        sut.getFruits { _ in
            completionBlockCalled = true
        }
        
        XCTAssertEqual(mockHttpClient.capturedRequestsCount, 1)
        XCTAssertEqual(mockHttpClient.lastCapturedHttpMethod, .get)
        XCTAssertEqual(mockHttpClient.lastCapturedPath, "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/data.json")
        XCTAssertNil(mockHttpClient.lastCapturedQueryParams)
        XCTAssertEqual(mockHttpClient.completionCalledCount, 1)
        XCTAssertTrue(completionBlockCalled)
    }
    
    /**
    *  Given:  getFruits request is made
    *  When:  server returned empty JSON data
    *  Then:    analytics request success method is called with correct time parameter
    *   And:    getFruits completion returns empty array of fruits
    */
    func testSuccessEmptyResponse() {
        let fruitsToReturn = fixtures.boxedFruitsEmpty
        let dataToReturn = fruitsToReturn.jsonData()
        mockHttpClient.dataToReturn = dataToReturn
        mockHttpClient.errorToReturn = nil
        let expectedRequestTime = 55
        mockHttpClient.mockedRequestTime = expectedRequestTime
        
        sut.getFruits { result in
            if case .success(let fruits) = result {
                XCTAssertEqual(fruits, [])
            } else {
                XCTFail("incorrect response")
            }
        }
        
        let analytics = mockAnalyticsProvider!
        XCTAssertEqual(analytics.networkRequestCompletedCalledCount, 1)
        XCTAssertEqual(analytics.errorDidOccurCalledCount, 0)
        
        let info = analytics.lastCapturedNetworkRequestCompletedInfo
        let expectedInfo = RequestMetadata(type: .get,
                                           apiPath: "data.json",
                                           apiHost: "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/")
        XCTAssertEqual(info, expectedInfo)
        
        let capturedTime = analytics.capturedNetworkRequestCompletedTimeInMs.last
        XCTAssertEqual(capturedTime, expectedRequestTime)
    }
    
    /**
    *  Given:  getFruits request is made
    *     And:  another getFruits request is made
    *  When:  both request succeed
    *   Then:  analytics request should be called twice with correct parameters
    */
    func testTwoGetFruitsRequests() {
        let fruitsToReturn = fixtures.boxedFruitsOneApple
        let dataToReturn = fruitsToReturn.jsonData()
        mockHttpClient.dataToReturn = dataToReturn
        mockHttpClient.errorToReturn = nil
        let firstRequestTime = 66
        mockHttpClient.mockedRequestTime = firstRequestTime
        
        sut.getFruits { _ in }
        
        let secondRequestTime = 77
        mockHttpClient.mockedRequestTime = secondRequestTime
        
        sut.getFruits { _ in }
        
        let analytics = mockAnalyticsProvider!
        XCTAssertEqual(analytics.networkRequestCompletedCalledCount, 2)
        XCTAssertEqual(analytics.errorDidOccurCalledCount, 0)
        XCTAssertEqual(analytics.capturedNetworkRequestCompletedTimeInMs, [66, 77])
    }
    
    /**
     *  When:  getFruits request succeeds
     *   And:   server returns some fruit data in JSON
     *  Then:   getFruits completion returns an array of fruits
     *   And:   analytics request success method is called
     */
    func testSuccess() {
        let fruitsToReturn = fixtures.boxedFruitsOneApple
        let apple = fruitsToReturn.fruit
        let dataToReturn = fruitsToReturn.jsonData()
        mockHttpClient.dataToReturn = dataToReturn
        mockHttpClient.errorToReturn = nil
        let mockedRequestTime = 88
        mockHttpClient.mockedRequestTime = mockedRequestTime
        
        sut.getFruits { result in
            if case .success(let fruits) = result {
                XCTAssertEqual(fruits, apple)
            } else {
                XCTFail("incorrect response")
            }
        }
        
        let analytics = mockAnalyticsProvider!
        XCTAssertEqual(analytics.networkRequestCompletedCalledCount, 1)
        XCTAssertEqual(analytics.errorDidOccurCalledCount, 0)
        
        let info = analytics.lastCapturedNetworkRequestCompletedInfo
        let expectedInfo = RequestMetadata(type: .get,
                                           apiPath: "data.json",
                                           apiHost: "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/")
        XCTAssertEqual(info, expectedInfo)
        
        let capturedTime = analytics.capturedNetworkRequestCompletedTimeInMs.last
        XCTAssertEqual(capturedTime, mockedRequestTime)
    }
    
    /**
     *  Given:   getFruitsRequest is made
     *  When:   network request returns an error
     *   Then:  completion block is called with correct error
     *    And:  analytics request failure method is called
     */
    func testNetworkCallFails() {
        mockHttpClient.errorToReturn = MockError.mockError
        
        sut.getFruits { result in
            switch result {
            case .success:
                XCTFail("incorrect response")
            case .failure(let error):
                XCTAssertTrue(error as NSError == MockError.mockError as NSError)
            }
        }
        XCTAssertEqual(mockAnalyticsProvider.networkRequestCompletedCalledCount, 0)
        XCTAssertEqual(mockAnalyticsProvider.errorDidOccurCalledCount, 1)
    }
    
    /**
     *  Given:  getFruits request is made
     *  When:  returned JSON data is malformed
     *  Then:   getFruits completion fails
     *   And:   analytics request failure method is called
     */
    func testMalformedJsonReturned() {
        mockHttpClient.dataToReturn = fixtures.malformedFruitsJSONData
        
        sut.getFruits { result in
            if case .success = result {
                XCTFail("incorrect response")
            }
        }
        XCTAssertEqual(mockAnalyticsProvider.networkRequestCompletedCalledCount, 0)
        XCTAssertEqual(mockAnalyticsProvider.errorDidOccurCalledCount, 1)
    }
}
