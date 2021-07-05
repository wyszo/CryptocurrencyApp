//
//  DefaultHttpClientTests.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import XCTest
import SwiftyMocky
import PromiseKit
@testable import CryptocurrencyApp

class DefaultHttpClientTests: XCTestCase {
    private var sut: DefaultHttpClient!
    private let dependencyResolver = TestDependencyResolver()
    private var requestSenderMock: URLRequestSenderProtocolMock!
    
    override func setUp() {
        super.setUp()
        dependencyResolver.resetState()
        requestSenderMock = dependencyResolver.requestSenderMock
        sut = DefaultHttpClient()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSendRequestSuccess() {
        // Given:  RequestSender.send stubbed with success
        let stubbbedData = Data(base64Encoded: "data")!
        let promise = Promise<Data>.value(stubbbedData)
        Given(requestSenderMock, .send(request: .any, willReturn: promise))
       
        // When:  SendRequest called
        let result = sut.sendRequest(method: .get,
                                     path: "http://path")
        waitFor(promise: result)
        
        // Then:  It shuld send a request with correct path and method
        Verify(requestSenderMock, 1, .send(request: .any))
        
        let expectedRequest = URLRequest(url: URL(string: "http://path")!)
        Verify(requestSenderMock, 1, .send(request: .value(expectedRequest)))
    }
    
    func testSendRequestFailure() {
        // Given:  RequestSender.send stubbed with failure
        let expectedError = MockedError.genericError
        let promise = Promise<Data>.init(error: expectedError)
        Given(requestSenderMock, .send(request: .any, willReturn: promise))
        
        // When:  SendRequest called
        let result = sut.sendRequest(method: .get,
                                     path: "http://path")
        
        var capturedData: Data?
        var capturedError: Error?
        waitFor(promise: result,
                value: &capturedData,
                error: &capturedError)
        
        // Then:  It should fail with an error
        XCTAssertNil(capturedData)
        XCTAssertNotNil(capturedError)
        XCTAssertEqual(capturedError as? MockedError, expectedError)
    }
    
    func testSendRequestQueryParams() {
        // Given: RequestSender.send stubbed with success
        let stubbbedData = Data(base64Encoded: "data")!
        let promise = Promise<Data>.value(stubbbedData)
        Given(requestSenderMock, .send(request: .any, willReturn: promise))
        
        // When:  SendRequest called with query param
        let params = [ "foo": "bar" ]
        let result = sut.sendRequest(method: .get, path: "http://path", queryParameters: params)
        waitFor(promise: result)
        
        // Then:  It should send a request with a correct url containing query params
        let expectedRequest = URLRequest(url: URL(string: "http://path?foo=bar")!)
        Verify(requestSenderMock, 1, .send(request: .value(expectedRequest)))
    }
    
    func testTwoSubsequentSameCallsMakeOnlyOneRequest() {
        // Given: RequestSender.send stubbed with success
        let stubbbedData = Data(base64Encoded: "data")!
        let promise = Promise<Data>.value(stubbbedData)
        Given(requestSenderMock, .send(request: .any, willReturn: promise))
        
        // And:  SendRequest called but has not completed yet
        let resultOne = sut.sendRequest(method: .get,
                                        path: "http://path")
        
        // When:  Another sendRequest call is made with the same parameters
        let resultTwo = sut.sendRequest(method: .get,
                                        path: "http://path")
        
        // And:  Both requests completed
        waitFor(promise: resultOne)
        waitFor(promise: resultTwo)
        
        // Then:  Only one request should be sent
        Verify(requestSenderMock, 1, .send(request: .any))
    }
    
    func testTwoSubsequentSameCallsReturnCorrectValueOnSuccess() {
        // Given: RequestSender.send stubbed with success
        let stubbbedData = Data(base64Encoded: "data")!
        let promise = Promise<Data>.value(stubbbedData)
        Given(requestSenderMock, .send(request: .any, willReturn: promise))
        
        // And:  SendRequest called
        let resultOne = sut.sendRequest(method: .get,
                                        path: "http://path")
        
        // And:  Another sendRequest call is made with the same parameters
        let resultTwo = sut.sendRequest(method: .get,
                                        path: "http://path")
        
        // When:  The requests succeed
        var capturedDataOne: Data?
        var capturedErrorOne: Error?
        waitFor(promise: resultOne,
                value: &capturedDataOne,
                error: &capturedErrorOne)
        
        var capturedDataTwo: Data?
        var capturedErrorTwo: Error?
        waitFor(promise: resultTwo,
                value: &capturedDataTwo,
                error: &capturedErrorTwo)
        
        // Then:  No errors should be thrown
        XCTAssertNil(capturedErrorOne)
        XCTAssertNil(capturedErrorTwo)
        
        // And:  Both calls should return correct value
        XCTAssertNotNil(capturedDataOne)
        XCTAssertNotNil(capturedDataTwo)
        XCTAssertEqual(capturedDataOne, stubbbedData)
        XCTAssertEqual(capturedDataTwo, stubbbedData)
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
    
    /**
     * Given: SendRequest call is made
     * And:   The request has completed
     * And:   Another sendRequest call is made with the same parameters
     * When:  The request completes
     * Then:  RequestSender should send two requests
     */
    func testTwoSubsequentCallsOneAfterAnotherNotCached() {
        XCTFail("Not implemented yet!")
    }
}

