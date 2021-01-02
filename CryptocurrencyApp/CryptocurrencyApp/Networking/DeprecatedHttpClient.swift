//
//  HttpClient.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
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
}

enum HttpClientError: Error {
    case InvalidParameters
}

@available(*, deprecated, message: "To be replaced by the new http client")
public protocol DeprecatedHttpClient {
    func sendRequest(method: HttpMethod,
                     path: String,
                     queryParameters: [String: String]?,
                     completion: @escaping NetworkResponse) throws
    
    func sendRequest(metadata: RequestMetadata,
                     completion: @escaping NetworkResponse) throws
}

extension DeprecatedHttpClient {
    // Default implementation allowing to skip queryParams
    func sendRequest(method: HttpMethod,
                     path: String,
                     completion: @escaping NetworkResponse) throws {
        try sendRequest(method: method,
                        path: path,
                        queryParameters: nil,
                        completion: completion)
    }
    
    func sendRequest(metadata: RequestMetadata, completion: @escaping NetworkResponse) throws {
        try sendRequest(method: metadata.type,
                        path: metadata.apiHost + metadata.apiPath,
                        completion: completion)
    }
}
