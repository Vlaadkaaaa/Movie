// Movie.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// Фильм
struct Movie {
    /// ID фильма
    let id: Int
    /// Описание
    let overview: String
    /// Путь к фото
    let posterPath: String
    /// Дата релиза
    let releaseDate: String
    /// Заголовок
    let title: String
    /// Рейтинг
    let voteAverage: Double
    /// Просмотры
    let voteCount: Int

    init(json: JSON) {
        id = json["id"].intValue
        overview = json["overview"].stringValue
        posterPath = json["poster_path"].stringValue
        releaseDate = json["release_date"].stringValue
        title = json["title"].stringValue
        voteAverage = json["vote_average"].doubleValue
        voteCount = json["vote_count"].intValue
    }
}
