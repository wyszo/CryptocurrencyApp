//
//  Assertions.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

func assertionFailureIfNotTesting(_ message: String) {
    guard !Environment.unitTests else {
        return
    }
    assertionFailure(message)
}

