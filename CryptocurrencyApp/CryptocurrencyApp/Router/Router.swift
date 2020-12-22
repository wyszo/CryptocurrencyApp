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
        var listVC: FruitListViewController?
        do {
            let timer: PerformanceTimer = PerformanceTimer()
            listVC = try UIStoryboard.main.viewController(ofType: FruitListViewController.self)
            listVC?.viewModel = FruitListViewModel(dataProvider: diContainer.fruitsDataProvider)
            listVC?.router = self
            listVC?.analyticsProvider = diContainer.analyticsProvider
            listVC?.viewDidFinishDrawing = { [weak self] in
                let timeInMs = timer.timeEllapsedInMs()
                let screenInfo = ScreenInfo(screenId: "fruitList")
                self?.diContainer.analyticsProvider.screenDidShow(screenInfo: screenInfo, timeInMs: timeInMs)
            }
        } catch let error {
            assertionFailure("Root View Controller initialisation failed with error: \(error)")
        }
        
        guard let viewController = listVC else { return nil }
        navigationController =  UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    func presentFruitDetailViewController(fruit: Fruit) {
        do {
            let timer: PerformanceTimer = PerformanceTimer()
            let controller = try UIStoryboard.main.viewController(ofType: FruitDetailViewController.self)
            controller.viewModel = FruitDetailViewModel(fruit: fruit)
            navigationController?.pushViewController(controller, animated: true)
            
            controller.viewDidFinishDrawing = { [weak self] in
                let timeInMs = timer.timeEllapsedInMs()
                let screenInfo = ScreenInfo(screenId: "fruitDetail")
                self?.diContainer.analyticsProvider.screenDidShow(screenInfo: screenInfo, timeInMs: timeInMs)
            }
        } catch let error {
            assertionFailure("View Controller initialisation failed with error: \(error)")
        }
    }
}
