//
//  RequestDescriptor.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

public struct RequestDescriptor: Equatable {
    let type: HttpMethod
    let apiPath: String
    let apiHost: String
    
    var fullUriString: String {
        return apiHost + apiPath
    }
}
