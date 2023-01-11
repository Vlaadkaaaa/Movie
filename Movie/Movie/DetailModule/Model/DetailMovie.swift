// DetailMovie.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// MovieGenreNetwork
struct DetailMovie: Codable {
    /// Жанры
    let genres: [String]
    /// Описание
    let overview: String
    /// Заголовок
    let title: String
    /// Путь к картинке
    let posterPath: String?

    init(json: JSON) {
        genres = json["genres"].arrayValue.map { $0["name"].stringValue }
        overview = json["overview"].stringValue
        title = json["title"].stringValue
        posterPath = json["poster_path"].stringValue
    }
}
