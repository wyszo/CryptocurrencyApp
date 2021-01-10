//
//  MockAnalyticsProvider.swift
//  CryptocurrencyAppTests
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

@testable import CryptocurrencyApp

public class MockAnalyticsProvider: DeprecatedAnalyticsProviderProtocol {
    
    var networkRequestCompletedCalledCount = 0
    var screenDidShowCalledCount = 0
    var errorDidOccurCalledCount = 0
    
    var lastCapturedNetworkRequestCompletedInfo: RequestMetadata?
    var capturedNetworkRequestCompletedTimeInMs = [Int]()
    
    public func networkRequestCompleted(requestInfo: RequestMetadata, timeInMs: Int) {
        networkRequestCompletedCalledCount += 1
        lastCapturedNetworkRequestCompletedInfo = requestInfo        
        capturedNetworkRequestCompletedTimeInMs.append(timeInMs)
    }
    
    public func screenDidShow(screenInfo: ScreenInfo, timeInMs: Int) {
        screenDidShowCalledCount += 1   
    }
    
    public func errorDidOccur(error: Error) {
        errorDidOccurCalledCount += 1
    }
}
