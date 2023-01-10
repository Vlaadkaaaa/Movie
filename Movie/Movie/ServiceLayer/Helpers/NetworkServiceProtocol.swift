// NetworkServiceProtocol.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// Протокол для сетевого слоя
protocol NetworkServiceProtocol {
    func fetchMovie(genre: MovieGenre, completion: @escaping (Result<JSON?, Error>) -> Void)
    func fetchMovieDetail(movieId: String, completion: @escaping (Result<JSON?, Error>) -> Void)
    func fetchActor(movieID: String, completion: @escaping (Result<JSON?, Error>) -> Void)
}

///
enum MovieGenre: String {
    case popular, upcoming
}
