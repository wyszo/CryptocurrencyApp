//
//  URLRequestSender.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import PromiseKit

public protocol URLRequestSender {
    func send(request: URLRequest) -> Promise<Data>
}

public class DefaultRequestSender: URLRequestSender {
    private let session = URLSession.shared
    
    public func send(request: URLRequest) -> Promise<Data> {

        return Promise<Data> { seal in
            let task = URLSession
                .shared
                .dataTask(with: request) { (data, response, error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            seal.reject(error)
                        }
                        seal.fulfill(data ?? Data())
                    }
                }
            task.resume()
        }
    }
}
