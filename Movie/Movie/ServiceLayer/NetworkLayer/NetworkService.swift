// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import Foundation

/// Менеджер запросов
final class NetworkManager: NetworkCoreService, NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let resultsText = "results"
        static let castText = "cast"
        static let imageRequestURL = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Public Methods

    func fetchMovie(genre: MovieGenre, completion: @escaping (Result<[Movie]?, Error>) -> Void) {
        fetchMovie(genre: genre) { result in
            switch result {
            case let .success(json):
                let movies = (json?[Constants.resultsText].arrayValue.map { Movie(json: $0) })
                completion(.success(movies))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchDetail(movieId: String, completion: @escaping (Result<DetailMovie?, Error>) -> Void) {
        fetchMovieDetail(movieId: movieId) { result in
            switch result {
            case let .success(json):
                guard let json else { return }
                completion(.success(DetailMovie(json: json)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchActorDetail(movieId: String, completion: @escaping (Result<[Actor]?, Error>) -> Void) {
        fetchActor(movieID: movieId) { result in
            switch result {
            case let .success(json):
                let actor = json?[Constants.castText].arrayValue.map { Actor(json: $0) }
                completion(.success(actor))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func fetchImage(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = "\(Constants.imageRequestURL)\(url)"
        AF.request(url).responseData { response in
            switch response.result {
            case let .success(data):
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
