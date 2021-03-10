//
//  HttpClient.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import PromiseKit

public protocol HttpClient: AutoMockable {
    func sendRequest(method: HttpMethod,
                     path: String,
                     queryParameters: [String: String]?) -> Promise<Data>
    
    func sendRequest(metadata: RequestDescriptor) -> Promise<Data>
}

extension HttpClient {
    /**
     * Default implementation allowing to skip queryParams
     */
    func sendRequest(method: HttpMethod,
                     path: String) -> Promise<Data> {
        return sendRequest(method: method,
                           path: path,
                           queryParameters: nil)
    }

    /**
     * Default implementation automatically populating path from metadata
     */
    func sendRequest(metadata: RequestDescriptor) -> Promise<Data> {
        return sendRequest(method: metadata.type,
                           path: metadata.fullUriString)
    }
}
