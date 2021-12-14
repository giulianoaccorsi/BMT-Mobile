//
//  Property.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import Foundation

struct ImmobileAPI: Codable {
    let items: [Immobile]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

// MARK: - Item
struct Immobile: Codable {
    let address, city: String?
    let createdAt: String?
    let itemDescription: String?
    let district: String?
    let forSale: Bool
    let id: Int
    let imgURL: String
    let price: Int
    let state: String?
    let top: Bool
    let userID: Int
    let telephone: String?
    
    enum CodingKeys: String, CodingKey {
        case address, city, telephone
        case createdAt = "created_at"
        case itemDescription = "description"
        case district
        case forSale = "for_sale"
        case id
        case imgURL = "img_url"
        case price, state, top
        case userID = "user_id"
    }
}
