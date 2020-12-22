//
//  Router.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit

protocol RouterProtocol {
    func createRootViewController() -> UINavigationController?
    func presentFruitDetailViewController(fruit: Fruit)
}

class Router: RouterProtocol {
    
    private var navigationController: UINavigationController?
    private let diContainer: DIContainerProtocol
    
    init(diContainer: DIContainerProtocol) {
        self.diContainer = diContainer
    }
    
    func createRootViewController() -> UINavigationController? {
        guard let vc = createListViewController() else {
            assertionFailure("Root ViewController initialization failed!")
            return nil
        }
        return UINavigationController(rootViewController: vc)
    }
    
    private func createListViewController() -> UIViewController? {
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
    
    func presentFruitDetailViewController(fruit: Fruit) {
        guard let controller = createFruitDetailViewController(fruit: fruit) else {
            assertionFailure("Fruit ViewController initialization failed!"); return
        }
        guard let navigationController = navigationController else {
            assertionFailure("Missing navigationController!"); return
        }
        navigationController.pushViewController(controller, animated: true)
    }
    
    private func createFruitDetailViewController(fruit: Fruit) -> UIViewController? {
        guard let controller = try? UIStoryboard.main.viewController(ofType: FruitDetailViewController.self) else {
            assertionFailure("Fruit ViewController initialization failed!")
            return nil
        }
        
        let timer: PerformanceTimer = PerformanceTimer()
        controller.viewModel = FruitDetailViewModel(fruit: fruit)
        navigationController?.pushViewController(controller, animated: true)
        
        controller.viewDidFinishDrawing = { [weak self] in
            let timeInMs = timer.timeEllapsedInMs()
            let screenInfo = ScreenInfo(screenId: .fruitDetail)
            self?.diContainer.analyticsProvider.screenDidShow(screenInfo: screenInfo, timeInMs: timeInMs)
        }
        return controller
    }
}
