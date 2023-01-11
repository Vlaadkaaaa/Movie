// Router.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Роутер
final class Router: RouterProtocol {
    // MARK: - Public Property

    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBilderProtocol?

    // MARK: - Init

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    // MARK: - Public Method

    func initialViewController() {
        if let navigationController {
            guard let mainVC = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainVC]
        }
    }

    func showDetail(id: Int) {
        if let navigationController {
            guard let detailVC = assemblyBuilder?.createDetailModule(id: "\(id)", router: self) else { return
            }
            navigationController.pushViewController(detailVC, animated: true)
        }
    }

    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
