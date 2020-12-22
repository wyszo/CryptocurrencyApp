//
//  AnalyticsProviderTests.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class AnalyticsProviderTests: XCTestCase {
    
    /** Normally I don't use force unwrap, but IMO in test code it's acceptable */
    private var sut: AnalyticsProvider!
    private let fixtures = Fixtures()
    private var mockHttpClient: MockHttpClient!
    
    override func setUp() {
        mockHttpClient = MockHttpClient()
        sut = AnalyticsProvider(httpClient: mockHttpClient)
    }
    
    override func tearDown() {
        mockHttpClient = nil
        sut = nil
    }
    
    /**
     *  When:   networkRequestCompleted is called
     *   Then:  stats endpoint request should be made with event=load and data=time in ms query params
     */
    func testNetworkRequestCompleted() {
        let mockedRequestInfo = RequestMetadata(type: .get,
                                          apiPath: "path",
                                          apiHost: "host")
        let timeInMs = 1100
        sut.networkRequestCompleted(requestInfo: mockedRequestInfo,
                                    timeInMs: timeInMs)
        
        XCTAssertEqual(mockHttpClient.capturedRequestsCount, 1)
        XCTAssertEqual(mockHttpClient.lastCapturedPath, "https://raw.githubusercontent.com/wyszo/master/stats")
        XCTAssertEqual(mockHttpClient.lastCapturedHttpMethod, .get)
        
        let expectedQueryParams: [String: String] = [
            "event": "load",
            "data": "1100"
        ]
        XCTAssertEqual(mockHttpClient.lastCapturedQueryParams, expectedQueryParams)
    }
    
    /**
     *  When:   screenDidShow is called
     *   Then:  stats endpoint request should be made with event=display and data=timeInMs query params
     */
    func testScreenDidShow() {
        let mockedScreenInfo = ScreenInfo(screenId: .fruitDetail)
        let timeInMs = 1200
        
        sut.screenDidShow(screenInfo: mockedScreenInfo, timeInMs: timeInMs)
        
        XCTAssertEqual(mockHttpClient.capturedRequestsCount, 1)
        XCTAssertEqual(mockHttpClient.lastCapturedPath, "https://raw.githubusercontent.com/wyszo/master/stats")
        XCTAssertEqual(mockHttpClient.lastCapturedHttpMethod, .get)
        
        let expectedQueryParams: [String: String] = [
            "event": "display",
            "data": "1200"
        ]
        XCTAssertEqual(mockHttpClient.lastCapturedQueryParams, expectedQueryParams)
    }
    
    /**
     *  When:   errorDidOccur is called
     *   Then:  stats endpoint request should be made with event=error and data=error.localizedDescription query params
     */
    func testErrorDidOccur() {
        let error = MockError.mockError
        sut.errorDidOccur(error: error)
        
        XCTAssertEqual(mockHttpClient.capturedRequestsCount, 1)
        XCTAssertEqual(mockHttpClient.lastCapturedPath, "https://raw.githubusercontent.com/wyszo/master/stats")
        XCTAssertEqual(mockHttpClient.lastCapturedHttpMethod, .get)
        
        let expectedQueryParams: [String: String] = [
            "event": "error",
            "data": "Mock error localized description."
        ]
        XCTAssertEqual(mockHttpClient.lastCapturedQueryParams, expectedQueryParams)
    }
}


public enum MockError: Error {
    case mockError
}

extension MockError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .mockError:
            return NSLocalizedString("Mock error localized description.", comment: "Mock error")
        }
    }
}
