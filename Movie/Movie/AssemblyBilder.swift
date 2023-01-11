// AssemblyBilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Протокол сборщика модулей
protocol AssemblyBilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController?
    func createDetailModule(id: String, router: RouterProtocol) -> UIViewController?
}

/// Сборщик модулей
final class AssemblyBilder: AssemblyBilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController? {
        let view = MovieViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }

    func createDetailModule(id: String, router: RouterProtocol) -> UIViewController? {
        let view = DescriptionViewController()
        let networkService = NetworkService()
        let presenter = DetailPresenter(view: view, id: id, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}
