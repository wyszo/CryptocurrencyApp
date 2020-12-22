//
//  SceneDelegate.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var router: RouterProtocol?
    private let diContainer = DIContainer()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)

        self.router = Router(diContainer: diContainer)
        
        self.window?.rootViewController = self.router?.createRootViewController()
        self.window?.makeKeyAndVisible()
    }
}
