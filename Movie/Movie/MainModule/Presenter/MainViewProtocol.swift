// MainViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол каталога фильмов
protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}
