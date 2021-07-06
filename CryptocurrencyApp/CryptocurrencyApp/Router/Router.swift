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
        guard let vc = createCryptoListViewController() else {
            assertionFailure("Root ViewController initialization failed!")
            return nil
        }
        navigationController = UINavigationController(rootViewController: vc)
        return navigationController
    }
    
    private func createCryptoListViewController() -> UIViewController? {
        guard let listVC = try? UIStoryboard.main.viewController(ofType: CryptoListViewController.self) else {
            assertionFailure("CryptoListViewController initialization failed!")
            return nil
        }
        return listVC
    }
    
    func presentCryptoDetailViewController(_ cryptocurrency: Cryptocurrency) {
        let detailController = resolver.resolve(CryptoDetailViewController.self, args: cryptocurrency)
        
        guard let navigationController = navigationController else {
            assertionFailure("Missing navigationController!"); return
        }
        navigationController.pushViewController(detailController, animated: true)
    }
}
