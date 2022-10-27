// MoviesGenreNetwork.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
struct MovieGenreNetwork: Codable {
    let genres: [Genres]
}

///
struct Genres: Codable {
    var name: String
}
