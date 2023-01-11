// Router.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(id: Int)
    func popToRoot()
}

final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBilderProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

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
