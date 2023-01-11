// ImageService.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Запрос изображений из сети
final class ImageRequest {
    // MARK: - Private Property

    private let url: URL

    // MARK: - Init

    init(url: URL) {
        self.url = url
    }
}

/// Запрос изображений в
extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> UIImage? {
        UIImage(data: data)
    }

    func execute(withCompletion completion: @escaping (Result<UIImage?, Error>) -> Void) {
        load(url, withCompletion: completion)
    }
}
