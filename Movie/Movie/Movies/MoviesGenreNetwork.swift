//
//  MoviesGenreNetwork.swift
//  Movie
//
//  Created by Владислав Лымарь on 26.10.2022.
//

import Foundation

///
struct MovieGenreNetwork: Codable {
    let genres: [Genres]
}

///
struct Genres: Codable {
    var name: String
}
