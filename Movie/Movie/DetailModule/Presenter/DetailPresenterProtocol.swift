// DetailPresenterProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол презентера конкретного фильма
protocol DetailPresenerProtocol: AnyObject {
    var view: DetailViewProtocol? { get set }
    var networkService: NetworkServiceProtocol { get set }
    var details: DetailMovie? { get set }
    var actors: [Actor] { get set }
    func fetchDetail()
    func fetchActorDetail()
}
