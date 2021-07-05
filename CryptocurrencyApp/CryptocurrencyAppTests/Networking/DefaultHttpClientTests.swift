//
//  DefaultHttpClientTests.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import XCTest
@testable import CryptocurrencyApp

class DefaultHttpClientTests: XCTestCase {
    private var sut: DefaultHttpClient!
    private let dependencyResolver = TestDependencyResolver()
    private var requestSenderMock: URLRequestSenderProtocolMock!
    
    override func setUp() {
        super.setUp()
        dependencyResolver.resetState()
        requestSenderMock = dependencyResolver.requestSenderMock
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    /**
     * Given: SendRequest call is made
     * And:   The request has not completed yet
     * When:  Another sendRequest call is made with the same parameters
     * Then:  Only one network request should be made
     */
    func testTwoSubsequentSameCallsMakeOnlyOneRequest() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     * Given: SendRequest call is made
     * And:   The request has not completed yet
     * And:   Another sendRequest call is made with the same parameters
     * When:  The request succeeds
     * Then:  Both calls return correct value
     */
    func testTwoSubsequentSameCallsReturnCorrectValueOnSuccess() {
        XCTFail("Not implemented yet!")
    }
    
    /**
     * Given: SendRequest call is made
     * And:   The request has not completed yet
     * And:   Another sendRequest call is made with the same parameters
     * When:  The request fails with an error
     * Then:  Both calls return a correct error
     */
    func testTwoSubsequentSameCallsReturnCorrectErrorOnFailure() {
        XCTFail("Not implemented yet!")
    }
}

