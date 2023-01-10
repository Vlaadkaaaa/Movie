// Movie.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// Массив фильмов
struct Movie {
    let id: Int
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
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
