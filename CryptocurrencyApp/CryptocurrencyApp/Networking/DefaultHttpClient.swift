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

    private var inFlightRequests = [RequestDescriptor: Promise<Data>]()
    
    func sendRequest(method: HttpMethod,
                     path: String,
                     queryParameters: [String: String]? = nil) -> Promise<Data> {
        
        let newRequest = RequestDescriptor(type: method,
                                           apiPath: path,
                                           apiHost: "",
                                           queryParams: queryParameters)
        
        if let request = requestInFlight(descriptor: newRequest) {
            return request
        }
        
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
            let sendRequest = requestSender.send(request: request)
            inFlightRequests[newRequest] = sendRequest
            
            sendRequest
                .done { data in
                    self.inFlightRequests.removeValue(forKey: newRequest)
                    seal.fulfill(data)
                }
                .catch { error in
                    self.inFlightRequests.removeValue(forKey: newRequest)
                    seal.reject(error)
                }
        }
    }
    
    private func requestInFlight(descriptor: RequestDescriptor) -> Promise<Data>? {
        let inFlight = inFlightRequests.contains { (key, _) in key == descriptor }
        if inFlight {
            guard let promise = inFlightRequests[descriptor] else {
                fatalError("impossible execution path")
            }
            return promise
        }
        return nil
    }
}
