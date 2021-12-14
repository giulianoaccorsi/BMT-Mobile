//
//  User.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import Foundation

struct User: Decodable {
    let fullName: String
    let email: String
    let password: String
    let telephone: String?
}
