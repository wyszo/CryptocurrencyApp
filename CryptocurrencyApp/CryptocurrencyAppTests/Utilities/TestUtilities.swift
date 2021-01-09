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
        let waitExpectation = XCTestExpectation(description: "Wating on a promise")
        
        promise.done { _ in
            waitExpectation.fulfill()
        }.catch { _ in
            waitExpectation.fulfill()
        }
        wait(for: [waitExpectation], timeout: 0.1)
    }
}
