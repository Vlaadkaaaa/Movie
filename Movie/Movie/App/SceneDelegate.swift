// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene

        else { return }
        window = UIWindow(windowScene: windowScene)
        let assembly = AssemblyBilder()
        let navController = UINavigationController()
        let router = Router(navigationController: navController, assemblyBuilder: assembly)
        router.initialViewController()
        window?.rootViewController = navController
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}
