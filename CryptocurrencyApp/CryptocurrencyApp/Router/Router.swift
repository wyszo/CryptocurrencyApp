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
    
    // deprecated
    func presentFruitDetailViewController(fruit: Fruit)
    
    func presentCryptoDetailViewController(_ cryptocurrency: Cryptocurrency)
}

class Router: RouterProtocol, Resolving {
    
    private var navigationController: UINavigationController?
    private let diContainer: DIContainerProtocol
    
    init(diContainer: DIContainerProtocol) {
        self.diContainer = diContainer
    }
    
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
    
    // deprecated
    private func createFruitListViewController() -> UIViewController? {
        guard let listVC = try? UIStoryboard.main.viewController(ofType: FruitListViewController.self) else {
            assertionFailure("List ViewController initialization failed!")
            return nil
        }
        
        let timer: PerformanceTimer = PerformanceTimer()
        listVC.viewModel = FruitListViewModel(dataProvider: diContainer.fruitsDataProvider)
        listVC.router = self
        listVC.analyticsProvider = diContainer.analyticsProvider
        
        listVC.viewDidFinishDrawing = { [weak self] in
            let timeInMs = timer.timeEllapsedInMs()
            let screenInfo = ScreenInfo(screenId: .fruitList)
            self?.diContainer.analyticsProvider.screenDidShow(screenInfo: screenInfo, timeInMs: timeInMs)
        }
        return listVC
    }
    
    // deprecated
    func presentFruitDetailViewController(fruit: Fruit) {
        guard let controller = createFruitDetailViewController(fruit: fruit) else {
            assertionFailure("Fruit ViewController initialization failed!"); return
        }
        guard let navigationController = navigationController else {
            assertionFailure("Missing navigationController!"); return
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    // deprecated
    private func createFruitDetailViewController(fruit: Fruit) -> UIViewController? {
        guard let controller = try? UIStoryboard.main.viewController(ofType: FruitDetailViewController.self) else {
            assertionFailure("Fruit ViewController initialization failed!")
            return nil
        }
        
        let timer: PerformanceTimer = PerformanceTimer()
        controller.viewModel = FruitDetailViewModel(fruit: fruit)
        
        controller.viewDidFinishDrawing = { [weak self] in
            let timeInMs = timer.timeEllapsedInMs()
            let screenInfo = ScreenInfo(screenId: .fruitDetail)
            self?.diContainer.analyticsProvider.screenDidShow(screenInfo: screenInfo, timeInMs: timeInMs)
        }
        return controller
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
