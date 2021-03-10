//
//  AnalyticsProviderProtocol.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

struct ScreenInfo {
    let screenId: ScreenId
}

@available(*, deprecated, message: "To be replaced by the new analytics provider")
protocol DeprecatedAnalyticsProviderProtocol {
    func networkRequestCompleted(requestInfo: RequestMetadata, timeInMs: Int)
    func screenDidShow(screenInfo: ScreenInfo, timeInMs: Int)
    func errorDidOccur(error: Error)
}
