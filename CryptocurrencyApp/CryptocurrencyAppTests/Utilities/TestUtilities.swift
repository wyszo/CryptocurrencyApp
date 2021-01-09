//
//  TestUtilities.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import XCTest
import PromiseKit

extension XCTestCase {
    
    func waitFor<T>(promise: Promise<T>) {
        var result: T?
        var error: Error?
        waitFor(promise: promise, value: &result, error: &error)
    }
    
    func waitFor<T>(promise: Promise<T>,
                    value: inout T?,
                    error: inout Error?) {
        let waitExpectation = XCTestExpectation(description: "Wating on a promise")
        
        var capturedValue: T?
        var capturedError: Error?
        
        promise.done { result in
            capturedValue = result
            waitExpectation.fulfill()
        }.catch { error in
            capturedError = error
            waitExpectation.fulfill()
        }
        wait(for: [waitExpectation], timeout: 0.1)
        
        value = capturedValue
        error = capturedError
    }
}
