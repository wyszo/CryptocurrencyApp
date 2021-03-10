//
//  MockedError.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

enum MockedError: Error {
    case genericError
}

extension MockedError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .genericError:
            return NSLocalizedString("Mock error localized description.", comment: "Mock error")
        }
    }
}
