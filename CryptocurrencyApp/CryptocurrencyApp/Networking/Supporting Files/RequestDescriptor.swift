//
//  RequestDescriptor.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

public struct RequestDescriptor: Equatable, Hashable {
    let type: HttpMethod
    let apiPath: String
    let apiHost: String
    let queryParams: [String: String]? 
    
    var fullUriString: String {
        return apiHost + apiPath
    }
}
