//
//  Environment.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

class Environment {
    static func isRunningUnitTests() -> Bool {
        if let _ = NSClassFromString("XCTest") {
            return true
        }
        return false
    }
}
