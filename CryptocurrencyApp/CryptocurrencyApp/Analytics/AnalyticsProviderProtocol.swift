//
//  AnalyticsProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

struct ScreenInfo {
    let screenId: String
}

protocol AnalyticsProviderProtocol {
    func networkRequestCompleted(requestInfo: RequestMetadata, timeInMs: Int)
    func screenDidShow(screenInfo: ScreenInfo, timeInMs: Int)
    func errorDidOccur(error: Error)
}
