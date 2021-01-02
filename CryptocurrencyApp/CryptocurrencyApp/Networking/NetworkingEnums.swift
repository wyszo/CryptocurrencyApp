//
//  NetworkingEnums.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
    case get
    case post
    case put
    case delete
    case path
}

public struct RequestMetadata: Equatable {
    let type: HttpMethod
    let apiPath: String
    let apiHost: String
    
    var fullUriString: String {
        return apiHost + apiPath
    }
}

enum HttpClientError: Error {
    case InvalidParameters
}
