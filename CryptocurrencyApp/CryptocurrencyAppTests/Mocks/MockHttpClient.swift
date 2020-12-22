//
//  MockHttpClient.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation
@testable import CryptocurrencyApp

class MockHttpClient: HttpClient {
    var capturedRequestsCount = 0
    
    var lastCapturedHttpMethod: HttpMethod?
    var lastCapturedPath: String?
    var lastCapturedQueryParams: [String: String]?
    var lastCapturedCompletion: NetworkResponse?
    
    var completionCalledCount = 0
    var dataToReturn: Data?
    var errorToReturn: Error?
    var mockedRequestTime = 99
    
    public func sendRequest(method: HttpMethod,
                     path: String,
                     queryParameters: [String: String]?,
                     completion: @escaping NetworkResponse) throws {
        capturedRequestsCount += 1
        
        lastCapturedHttpMethod = method
        lastCapturedPath = path
        lastCapturedQueryParams = queryParameters
        lastCapturedCompletion = completion
        
        if let data = dataToReturn {
            completionCalledCount += 1
            completion(.success(data), mockedRequestTime)
        } else if let error = errorToReturn {
            completionCalledCount += 1
            completion(.failure(error), mockedRequestTime)
        }
    }
}
