//
//  URLRequestSender.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

public typealias NetworkResponse = (Result<Data, Error>, Int) -> ()

public protocol URLRequestSender {
    func send(request: URLRequest,
              completion: @escaping NetworkResponse)
}

public class DefaultRequestSender: URLRequestSender {
    private let session = URLSession.shared
    
    public func send(request: URLRequest,
                     completion: @escaping NetworkResponse) {
        let requestTimer = PerformanceTimer()
        
        let task = URLSession.shared
            .dataTask(with: request) { (data, response, error) in
            let timeInMs = requestTimer.timeEllapsedInMs()
                
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error), timeInMs)
                    return
                }
                completion(.success(data ?? Data()), timeInMs)
            }
        }
        task.resume()
    }
}