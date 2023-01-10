// NetworkManager.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import SwiftyJSON

/// Менеджер запросов
final class NetworkManager: NetworkServiceProtocol {
    // MARK: - Private Constants

    private enum Constants {
        static let apiRequestURL = "https://api.themoviedb.org/3/movie/"
        static let apiKeyURL = "api_key=d9e4494907230d135d6f6fd47beca82e"
        static let apiLanguageURL = "language=ru"
        static let imageRequestURL = "https://image.tmdb.org/t/p/w500"
        static let apiResponseURL = "append_to_response=videos"
        static let apiCreditsGenreURL = "credits"
    }

    // MARK: - Public Methods

    func fetchMovie(genre: MovieGenre, completion: @escaping (Result<JSON?, Error>) -> Void) {
        let url = "\(Constants.apiRequestURL)\(genre.rawValue)?\(Constants.apiKeyURL)&\(Constants.apiLanguageURL)"
        alamofireRequest(url: url, completion: completion)
    }

    func fetchMovieDetail(movieId: String, completion: @escaping (Result<JSON?, Error>) -> Void) {
        let url = "\(Constants.apiRequestURL)\(movieId)?\(Constants.apiKeyURL)&" +
            "\(Constants.apiResponseURL)&\(Constants.apiLanguageURL)"
        alamofireRequest(url: url, completion: completion)
    }

    func fetchActor(movieID: String, completion: @escaping (Result<JSON?, Error>) -> Void) {
        let url = "\(Constants.apiRequestURL)\(movieID)/" +
            "\(Constants.apiCreditsGenreURL)?\(Constants.apiKeyURL)"
        alamofireRequest(url: url, completion: completion)
    }

    // MARK: - Private Method

    private func alamofireRequest(url: String, completion: @escaping (Result<JSON?, Error>) -> Void) {
        AF.request(url).responseData { reponse in
            switch reponse.result {
            case let .success(value):
                let json = JSON(value)
                completion(.success(json))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
