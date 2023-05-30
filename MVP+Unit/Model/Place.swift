//
//  Place.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

import Foundation

// MARK: - Welcome
struct Place: Codable {
    let success: Bool?
    let time: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let geo: Geo?
    var categories: [Category]?
    let objects: [Object]?
}

// MARK: - Category
struct Category: Codable {
    let name: String?
    let type: TypeEnum?
    let icon: String?
    let color: String?
    let count: Int?
    
    init(name: String?, type: TypeEnum?, icon: String?, color: String?, count: Int?) {
        self.name = name
        self.type = type
        self.icon = icon
        self.color = color
        self.count = count
    }
}

enum TypeEnum: String, Codable {
    case child = "child"
    case food = "food"
    case fun = "fun"
    case gift = "gift"
    case infrastructure = "infrastructure"
    case place = "place"
    case shop = "shop"
}

// MARK: - Geo
struct Geo: Codable {
    let lat, lon: Double?
}

// MARK: - Object
struct Object: Codable {
    let id: Int?
    let name, description: String?
    let image: String?
    let type: TypeEnum?
    let close: Bool?
    let icon: String?
    let color: String?
    let lat, lon: Double?
    let workingHours: [WorkingHour]?

    enum CodingKeys: String, CodingKey {
        case id, name, description, image, type, close, icon, color, lat, lon
        case workingHours = "working_hours"
    }
}

// MARK: - WorkingHour
struct WorkingHour: Codable {
    let days: [Int]?
    let from, to: String?
}

