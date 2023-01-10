// Genre.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// MovieGenreNetwork
struct DetailMovie: Codable {
    let genres: [Genre]
    let overview: String
    let title: String
    let posterPath: String?

    init(json: JSON) {
        genres = json["genres"].arrayObject as? [Genre] ?? []
        overview = json["overview"].stringValue
        title = json["title"].stringValue
        posterPath = json["poster_path"].stringValue
    }
}

/// Genres
struct Genre: Codable {
    let name: String
}
