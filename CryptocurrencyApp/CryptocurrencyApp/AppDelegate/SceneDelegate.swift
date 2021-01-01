//
//  SceneDelegate.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @Injected private var router: RouterProtocol

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        self.window?.rootViewController = self.router.createRootViewController()
        self.window?.makeKeyAndVisible()
    }
}
