//
//  InternetConnection.swift
//  TechnicalTestRamiro
//
//  Created by Ramiro Gutierrez on 10/04/24.
//

import Alamofire

class InternetConnection {
    static let shared = InternetConnection()
    
    private let reachabilityManager = NetworkReachabilityManager(host: "www.apple.com")
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        reachabilityManager?.startListening(onUpdatePerforming: { status in
        })
    }
    
    func isConnectedToInternet() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
}
