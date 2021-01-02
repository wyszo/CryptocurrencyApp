//
//  FruitsDataProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

protocol FruitsDataProvider {
    typealias FruitsCompletion = (Result<[Fruit], Error>) -> ()
    
    func getFruits(completion: @escaping FruitsCompletion)
}

class DefaultFruitsDataProvider: FruitsDataProvider {
    private let httpClient: DeprecatedHttpClient
    private let analyticsProvider: AnalyticsProviderProtocol
    
    lazy var fruitsRequestMetadata: RequestMetadata = {
        return RequestMetadata(type: .get,
                               apiPath: RequestConstants.getFruitsPath,
                               apiHost: APISettings.host)
    }()
    
    init(httpClient: DeprecatedHttpClient,
         analyticsProvider: AnalyticsProviderProtocol) {
        self.httpClient = httpClient
        self.analyticsProvider = analyticsProvider
    }
    
    func getFruits(completion: @escaping FruitsCompletion) {
        do {
            try httpClient.sendRequest(metadata: fruitsRequestMetadata) {
                [weak self] result, timeInMs in
                self?.handleResponse(result: result, timeInMs: timeInMs, completion: completion)
            }
        } catch (let error) {
            completion(.failure(error))
            analyticsProvider.errorDidOccur(error: error)
        }
    }
    
    private func handleResponse(result: Result<Data, Error>,
                                timeInMs: Int,
                                completion: @escaping FruitsCompletion) {
        switch result {
        case .success(let data):
            do {
                let fruits = try DefaultJSONDecoder<BoxedFruit>().decode(data: data).fruit
                completion(.success(fruits))
                analyticsProvider.networkRequestCompleted(requestInfo: fruitsRequestMetadata, timeInMs: Int(timeInMs))
            }
            catch {
                completion(.failure(error))
                analyticsProvider.errorDidOccur(error: error)
            }
                                 
        case .failure(let error):
            analyticsProvider.errorDidOccur(error: error)
            completion(.failure(error))
        }
    }
    
    private struct RequestConstants {
        static let getFruitsPath = "data.json"
    }
}

private struct APISettings {
    // ideally schema should be separate from host
    static let host = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/"
}
