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
        guard let controller = createCryptoDetailViewController(cryptocurrency) else {
            assertionFailure("CryptoDetailViewController initialization failed!"); return
        }
        guard let navigationController = navigationController else {
            assertionFailure("Missing navigationController!"); return
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func createCryptoDetailViewController(_ cryptocurrency: Cryptocurrency) -> UIViewController? {
        guard let controller = try? UIStoryboard.main.viewController(ofType: CryptoDetailViewController.self) else {
            assertionFailure("CryptoDetailViewController initialization failed!")
            return nil
        }
        
        controller.viewModel = resolver.optional(args: cryptocurrency)
        return controller
    }
}
