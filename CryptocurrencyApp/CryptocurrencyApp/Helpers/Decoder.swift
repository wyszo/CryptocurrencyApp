//
//  Decoder.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

protocol ModelDecoder {
    associatedtype T: Decodable
    
    func decode(data: Data) throws -> T
}

class DefaultJSONDecoder<T: Decodable>: ModelDecoder {
    func decode(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
