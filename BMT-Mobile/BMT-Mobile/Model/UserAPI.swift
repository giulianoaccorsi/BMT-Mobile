//
//  UserAPI.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 24/05/21.
//


// MARK: - Notification
struct UserAPI: Codable {
    let email: String
    let emailConfirmed: Bool
    let fullName: String
    let telephone: String
    let id: Int
    let admin: Bool

    enum CodingKeys: String, CodingKey {
        case email, telephone, id, admin
        case emailConfirmed = "email_confirmed"
        case fullName = "full_name"
    }
}

struct Token: Codable {
    let token: String
}


