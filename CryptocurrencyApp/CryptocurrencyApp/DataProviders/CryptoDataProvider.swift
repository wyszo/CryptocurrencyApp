//
//  CryptoDataProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import PromiseKit
import Resolver

protocol CryptoDataProviderProtocol: AnyObject, AutoMockable {
    func getCryptocurrencies() -> Promise<CryptocurrencyList>
}

class CryptoDataProvider: CryptoDataProviderProtocol {
    
    @Injected private var httpClient: HttpClient
    
    func getCryptocurrencies() -> Promise<CryptocurrencyList> {
        
        let metadata = RequestDescriptor(type: .get,
                                         apiPath: RequestConstants.getCryptocurrenciesPath,
                                         apiHost: APISettings.host,
                                         queryParams: nil)
        
        return Promise<CryptocurrencyList> { seal in
            httpClient.sendRequest(metadata: metadata).done { data in
                let decoder = DefaultJSONDecoder<CryptocurrencyList>()
                do {
                    let list = try decoder.decode(data: data)
                    seal.fulfill(list)
                } catch (let error) {
                    assertionFailureIfNotTesting("JSON Decoding error: \(error.localizedDescription)")
                    seal.reject(error)
                }
            }.catch { error in
                // This will need to be handled in the UI, not as an assertion
                assertionFailureIfNotTesting("Network error: \(error.localizedDescription)")
                seal.reject(error)
            }
        }
    }
    
    struct RequestConstants {
        static let getCryptocurrenciesPath = "Cryptocurrencies.json"
    }
}

private struct APISettings {
    static let host = "https://storage-cryptocurrency-app-dev.s3-eu-west-1.amazonaws.com/"
}
