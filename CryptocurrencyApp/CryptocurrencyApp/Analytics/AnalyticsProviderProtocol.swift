//
//  AnalyticsProviderProtocol.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

protocol AnalyticsProviderProtocol: AnyObject, AutoMockable {
    func screenView(_: ScreenId)
    func cryptocurrencyListItemSelected(_: Cryptocurrency)
}
