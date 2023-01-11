// MainViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентер каталога фильмов
protocol MainViewPresenterProtocol {
    var movies: [Movie] { get set }
    var networkService: NetworkServiceProtocol? { get set }
    var movieGenre: MovieGenre { get set }
    func fetchMovie(genre: MovieGenre)
    func showDetail(id: Int)
    func updateSegmentControl(page: Int)
}
