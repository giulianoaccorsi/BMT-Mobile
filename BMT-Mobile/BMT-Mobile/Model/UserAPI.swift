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
    let id: Int

    enum CodingKeys: String, CodingKey {
        case email
        case emailConfirmed = "email_confirmed"
        case fullName = "full_name"
        case id
    }
}

struct Token: Codable {
    let token: String
}


