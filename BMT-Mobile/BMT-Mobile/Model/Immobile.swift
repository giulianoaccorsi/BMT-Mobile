//
//  Property.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import Foundation

struct ImmobileAPI: Codable {
    let items: [Immobile]
}

// MARK: - Item
struct Immobile: Codable {
    let createdAt, itemDescription: String
    let id: Int
    let imgURL: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case itemDescription = "description"
        case id
        case imgURL = "img_url"
        case title
    }
}
