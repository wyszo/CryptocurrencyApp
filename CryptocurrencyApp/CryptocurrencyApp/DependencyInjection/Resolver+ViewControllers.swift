//
//  Resolver+ViewControllers.swift
//  CryptocurrencyApp
//
//  Copyright © 2021 Thomas Wyszomirski. All rights reserved.
//

import Foundation
import Resolver

extension Resolver {
    
    static func registerViewControllers() {
        register(CryptoDetailViewController.self) { (_, args) in
            guard let controller = try? UIStoryboard.main.viewController(ofType: CryptoDetailViewController.self) else {
                assertionFailure("CryptoDetailViewController initialization failed!")
                return nil
            }
            controller.viewModel = optional(args: args())
            return controller
        }
    }
}
