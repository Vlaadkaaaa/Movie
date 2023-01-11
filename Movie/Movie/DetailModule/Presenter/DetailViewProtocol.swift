// DetailViewProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол конкретного фильма
protocol DetailViewProtocol {
    func succes()
    func failure(error: Error)
    func setupUI(detail: DetailMovie?)
}
