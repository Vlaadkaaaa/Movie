// MainPresenter.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

///
protocol MainViewProtocol: AnyObject {
    func success(json: JSON?)
    func failure(error: Error)
}

///
protocol MainViewPresenterProtocol {
    var movies: [Movie]? { get set }
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol)
    func fetchMovie(genre: MovieGenre)
}

///
class MainPresenter: MainViewPresenterProtocol {
    let view: MainViewProtocol
    var movies: [Movie]?
    var networkService: NetworkServiceProtocol?

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
    }

    func fetchMovie(genre: MovieGenre) {
        networkService?.fetchMovie(genre: genre) { result in
            switch result {
            case let .success(json):
                self.view.success(json: json)
            case let .failure(error):
                self.view.failure(error: error)
            }
        }
    }
}
