// MainPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import SwiftyJSON

/// Презентер каталога фильмов
class MainPresenter: MainViewPresenterProtocol {
    // MARK: - Public Property

    weak var view: MainViewProtocol?
    var movies: [Movie] = []
    var movieGenre: MovieGenre = .popular
    var networkService: NetworkServiceProtocol?
    var router: RouterProtocol?

    // MARK: - Init

    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }

    // MARK: - Public Method

    func fetchMovie(genre: MovieGenre) {
        networkService?.fetchMovie(genre: genre) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(movie):
                guard let movie else { return }
                self.movies += movie
                self.view?.success()
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }

    func showDetail(id: Int) {
        router?.showDetail(id: id)
    }

    func updateSegmentControl(page: Int) {
        switch page {
        case 0:
            movieGenre = .popular
        default:
            movieGenre = .upcoming
        }
        fetchMovie(genre: movieGenre)
    }
}
