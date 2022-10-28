// MoviesDescriptionNetwork.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///
struct MoviewDescriptionNetwork: Codable {
    let id: Int
    let cast: [Cast]
}

///
struct Cast: Codable {
    let name: String
    let profilePath: String?
    let character: String

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}
