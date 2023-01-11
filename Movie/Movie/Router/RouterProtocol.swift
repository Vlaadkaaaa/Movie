// RouterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для роутера
protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(id: Int)
    func popToRoot()
}
