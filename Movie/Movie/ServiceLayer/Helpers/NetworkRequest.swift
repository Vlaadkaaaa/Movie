// NetworkRequest.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
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
        AF.request(url).responseData { [weak self] response in
            guard let self else { return }
            switch response.result {
            case let .success(data):
                guard let decodeData = self.decode(data) else { return }
                completion(.success(decodeData))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
