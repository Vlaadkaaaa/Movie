// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Протокол для сетевого слоя
protocol NetworkServiceProtocol {
    func fetchMovie(genre: MovieGenre, completion: @escaping (Result<[Movie]?, Error>) -> Void)
    func fetchDetail(movieId: String, completion: @escaping (Result<DetailMovie?, Error>) -> Void)
    func fetchActorDetail(movieId: String, completion: @escaping (Result<[Actor]?, Error>) -> Void)
}

/// Жанры фильмов
enum MovieGenre: String {
    case popular, upcoming
}
