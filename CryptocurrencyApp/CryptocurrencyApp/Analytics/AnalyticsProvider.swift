//
//  AnalyticsProvider.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Foundation

public class AnalyticsProvider: AnalyticsProviderProtocol {
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    /**
     *  A call informing that network request to the API has been made.
     *  Makes a call to stats endpoint with event=load, data=timeInMs.
     *
     *  - Parameter requestInfo     Data describing network request the call describes. Currently ignored. In reall API it'd be passed as a parameter to the stats call.
     *  - Parameter timeInMs    Time (in milliseconds) it took to execute a network request
     */
    func networkRequestCompleted(requestInfo: RequestMetadata, timeInMs: Int) {
        makeStatsEndpointRequest(event: "load", data: String(timeInMs))
    }
    
    /**
     *  A call informing that the user changed current app view.
     *  Makes a call to stats endpiont with event=display, data=timeInMs.
     *
     *  - Parameter screenInfo  Additional data describing a screen the app moved to. Currently ignored. It'd be passed to the API in a real scenario to determine which screen the analytics call refers to.
     *  - Parameter timeInMs    Time (in milliseconds) from initiating a network request to finishing drawing data on a new screen.
     */
    func screenDidShow(screenInfo: ScreenInfo, timeInMs: Int) {
        makeStatsEndpointRequest(event: "display", data: String(timeInMs))
    }
    
    /**
     *  A call notifying about a problem - an exception or a crash
     *  Makes a call to stats endpoint with event=error, data=errorDescription
     *
     *  - Parameter error   An error to be propagated to server. Localized description will be send.
     */
    func errorDidOccur(error: Error) {
        makeStatsEndpointRequest(event: "error", data: error.localizedDescription)
    }
    
    private func makeStatsEndpointRequest(event: String, data: String) {
        let parameters: [String: String] = [
            Constants.eventParamName: event,
            Constants.dataParamName: data
        ]
               
        try? httpClient.sendRequest(method: .get, path: Constants.statsEndpoint, queryParameters: parameters) { _, _ in }
    }
    
    struct Constants {
        static let statsEndpoint =  "https://raw.githubusercontent.com/wyszo/master/stats"
        static let eventParamName = "event"
        static let dataParamName = "data"
    }
}
