// Actor.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// Модель  актеры
struct Actor: Codable {
    let name: String
    let profilePath: String?
    let character: String

    init(json: JSON) {
        name = json["name"].stringValue
        profilePath = json["profile_path"].stringValue
        character = json["character"].stringValue
    }
}
