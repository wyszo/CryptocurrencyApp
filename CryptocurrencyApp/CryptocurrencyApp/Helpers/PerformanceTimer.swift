//
//  PerformanceTimer.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

protocol PerformanceTimerProtocol {
    init()
    func restart()
    func timeEllapsedInMs() -> Int
}

class PerformanceTimer: PerformanceTimerProtocol {
    private var startTime: DispatchTime
    
    required init() {
        startTime = DispatchTime.now()
    }
    
    func restart() {
        startTime = DispatchTime.now()
    }
    
    func timeEllapsedInMs() -> Int {
        let now = DispatchTime.now()
        let ellapsedNanoseconds = now.uptimeNanoseconds - startTime.uptimeNanoseconds
        return Int(ellapsedNanoseconds / 1_000_000)
    }
}
