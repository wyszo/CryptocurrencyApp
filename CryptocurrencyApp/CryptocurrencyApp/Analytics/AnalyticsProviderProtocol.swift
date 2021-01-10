//
//  AnalyticsProviderProtocol.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation

protocol AnalyticsProviderProtocol: AnyObject, AutoMockable {
    func cryptocurrencyListItemSelected(_: Cryptocurrency)
}
