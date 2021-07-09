//
//  Router.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit
import Resolver

protocol RouterProtocol: AutoMockable {
    func createRootViewController() -> UINavigationController?
    func presentCryptoDetailViewController(_ cryptocurrency: Cryptocurrency)
}

class Router: RouterProtocol, Resolving {
    
    private var navigationController: UINavigationController?
    
    func createRootViewController() -> UINavigationController? {
        let listVC = resolver.resolve(CryptoListViewController.self)
        navigationController = UINavigationController(rootViewController: listVC)
        return navigationController
    }
    
    func presentCryptoDetailViewController(_ cryptocurrency: Cryptocurrency) {
        let detailController = resolver.resolve(CryptoDetailViewController.self, args: cryptocurrency)
        
        guard let navigationController = navigationController else {
            assertionFailure("Missing navigationController!"); return
        }
        navigationController.pushViewController(detailController, animated: true)
    }
}
