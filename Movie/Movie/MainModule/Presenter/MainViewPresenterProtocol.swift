// MainViewPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентер каталога фильмов
protocol MainViewPresenterProtocol {
    var movies: [Movie] { get set }
    var movieGenre: MovieGenre { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func fetchMovie(genre: MovieGenre)
    func showDetail(id: Int)
    func updateSegmentControl(page: Int)
}
