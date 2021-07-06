//
//  URLRequestSenderProtocol.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import PromiseKit

public protocol URLRequestSenderProtocol: AutoMockable {
    func send(request: URLRequest) -> Promise<Data>
}
