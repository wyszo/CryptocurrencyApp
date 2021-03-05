//
//  Environment.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

class Environment {
    static var unitTests: Bool {
        if let _ = NSClassFromString("XCTest") {
            return true
        }
        return false
    }
    
    static var debug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
