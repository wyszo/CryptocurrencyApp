//
//  DefaultHttpClient.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import PromiseKit
import Resolver

class DefaultHttpClient: HttpClient {
    @Injected private var requestSender: URLRequestSenderProtocol

    func sendRequest(method: HttpMethod,
                     path: String,
                     queryParameters: [String: String]? = nil) -> Promise<Data> {
        
        return Promise<Data> { seal in
            var urlComponents = URLComponents(string: path)
            
            if let params = queryParameters {
                urlComponents?.queryItems = params.map {
                    return URLQueryItem(name: $0.key,
                                        value: $0.value)
                }
            }
            guard let absoluteURL = urlComponents?.url else {
                seal.reject(HttpClientError.InvalidParameters)
                return
            }
            
            let request = URLRequest(url: absoluteURL)
            requestSender.send(request: request)
                .done { data in
                    seal.fulfill(data)
                }
                .catch { error in
                    seal.reject(error)
                }
        }
    }
}
