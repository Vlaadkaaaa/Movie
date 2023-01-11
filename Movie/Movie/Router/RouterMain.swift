// RouterMain.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Базовый роутер
protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBilderProtocol? { get set }
}
