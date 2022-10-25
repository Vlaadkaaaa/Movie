// NetworkManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
enum GetMoviesResult {
    case success(movies: MoviesNetwork)
    case failure(error: Error)
}

///
final class NetworkManager {
    private let session = URLSession.shared
    private let decoder = JSONDecoder()

    func getMovies(genre: String, completion: @escaping (GetMoviesResult) -> Void) {
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/\(genre)?api_key=d9e4494907230d135d6f6fd47beca82e&language=ru-RU"
            )
        else { return }
        session.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            if error == nil, let parseData = data {
                guard let posts = try? self.decoder.decode(MoviesNetwork.self, from: parseData) else { return }
                completion(.success(movies: posts))
            } else {
                guard let error = error else { return }
                completion(.failure(error: error))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
