//
//  DefaultHttpClient.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

/**
 * Alternatively we could just use Alamofire
 */
class DefaultHttpClient: DeprecatedHttpClient {
    private let requestSender: DeprecatedURLRequestSender
    
    init(requestSender: DeprecatedURLRequestSender = DefaultRequestSender()) {
        self.requestSender = requestSender
    }
    
    func sendRequest(method: HttpMethod,
                     path: String,
                     queryParameters: [String: String]? = nil,
                     completion: @escaping NetworkResponse) throws {
        
        var urlComponents = URLComponents(string: path)
        
        if let params = queryParameters {
            urlComponents?.queryItems = params.map { return URLQueryItem(name: $0.key, value: $0.value) }
        }        
        guard let absoluteURL = urlComponents?.url else {
            throw HttpClientError.InvalidParameters
        }
        
        let request = URLRequest(url: absoluteURL)
        requestSender.send(request: request, completion: completion)
    }
}
