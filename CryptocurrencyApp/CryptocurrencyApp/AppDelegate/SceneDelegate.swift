//
//  SceneDelegate.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit
import Resolver

class SceneDelegate: UIResponder, UIWindowSceneDelegate, Resolving {

    var window: UIWindow?
    private var router: RouterProtocol!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard Environment.isRunningTests() == false else {
            return
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)

        self.router = resolver.resolve()
        self.window?.rootViewController = self.router.createRootViewController()
        self.window?.makeKeyAndVisible()
    }
}
