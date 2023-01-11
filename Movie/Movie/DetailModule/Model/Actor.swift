// Actor.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON

/// Актер
struct Actor: Codable {
    /// Имя актера
    let name: String
    /// Путь к фото
    let profilePath: String?
    /// Описание
    let character: String

    init(json: JSON) {
        name = json["name"].stringValue
        profilePath = json["profile_path"].stringValue
        character = json["character"].stringValue
    }
}
