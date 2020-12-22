//
//  AnalyticsProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

enum ScreenId: String {
    case fruitList
    case fruitDetail
}

struct ScreenInfo {
    let screenId: ScreenId
}

protocol AnalyticsProviderProtocol {
    func networkRequestCompleted(requestInfo: RequestMetadata, timeInMs: Int)
    func screenDidShow(screenInfo: ScreenInfo, timeInMs: Int)
    func errorDidOccur(error: Error)
}
