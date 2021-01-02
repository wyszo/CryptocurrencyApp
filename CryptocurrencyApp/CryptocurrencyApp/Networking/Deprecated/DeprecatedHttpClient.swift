//
//  HttpClient.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

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
