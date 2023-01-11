// DetailPresenter.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Презентер конкретного фильма
final class DetailPresenter: DetailPresenerProtocol {
    // MARK: - Public Property

    var view: DetailViewProtocol?
    var details: DetailMovie?
    var actors: [Actor] = []
    var networkService: NetworkServiceProtocol
    var router: RouterProtocol
    var id = ""

    // MARK: - Init

    required init(
        view: DetailViewProtocol,
        id: String,
        networkService: NetworkServiceProtocol,
        router: RouterProtocol
    ) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.id = id
    }

    // MARK: - Public Methods

    func fetchDetail() {
        networkService.fetchDetail(movieId: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(detail):
                self.details = detail
                self.view?.setupUI(detail: detail)
                self.view?.succes()
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }

    func fetchActor() {
        networkService.fetchActorDetail(movieId: id) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(actor):
                guard let actor else { return }
                self.actors = actor
                self.view?.succes()
            case let .failure(error):
                self.view?.failure(error: error)
            }
        }
    }
}
