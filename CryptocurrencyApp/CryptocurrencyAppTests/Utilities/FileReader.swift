//
//  FileReader.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import PromiseKit

class FileReader {
    private var testBundle: Bundle {
        return Bundle(for: type(of: self))
    }

    func dataFromFile(named filename: String) throws -> Data? {
        guard let url = testBundle.url(forResource: filename,
                                       withExtension: nil) else {
            assertionFailure("Missing test file!")
            throw FileReaderError.notFound
        }
        guard let data = try? Data(contentsOf: url) else {
            assertionFailure("Can't read test file")
            throw FileReaderError.readFailure
        }
        return data
    }
    
    func promiseFromFile(_ filename: String) -> Promise<Data> {
        return Promise<Data> { seal in
            do {
                if let data = try dataFromFile(named: filename) {
                    seal.fulfill(data)
                }
            } catch let error {
                seal.reject(error)
            }
        }
    }
    
    enum FileReaderError: Error {
        case notFound
        case readFailure
    }
}
