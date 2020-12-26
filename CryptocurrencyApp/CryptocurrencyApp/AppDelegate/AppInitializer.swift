//
//  AppInitializer.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import Firebase
import Resolver

class AppInitialiser {
    func initializeApp() {
        initializeLibraries()
        initializeDependencyInjection()
    }
    
    private func initializeLibraries() {
        FirebaseApp.configure()
    }
    
    private func initializeDependencyInjection() {
        Resolver.registerDependencies()
    }
}
