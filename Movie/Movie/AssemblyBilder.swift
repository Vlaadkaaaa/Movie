// AssemblyBilder.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

protocol AssemblyBilderProtocol {
    static func createMainModule() -> UIViewController?
    static func createDetailModule() -> UIViewController?
}

final class AssemblyBilder {
    static func createMainModule() -> UIViewController? {
        let view = MovieViewController()
        let networkService = NetworkManager()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }

    static func createDetailModule() -> UIViewController? {
        nil
    }
}
