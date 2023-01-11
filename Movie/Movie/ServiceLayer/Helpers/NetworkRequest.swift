// NetworkRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Общий сетевой запрос
protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (Result<ModelType?, Error>) -> Void)
}

/// Реализация сетевого запроса
extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (Result<ModelType?, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data,
                  let value = self.decode(data)
            else {
                guard let error = error else { return }
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            DispatchQueue.main.async {
                completion(.success(value))
            }
        }.resume()
    }
}
