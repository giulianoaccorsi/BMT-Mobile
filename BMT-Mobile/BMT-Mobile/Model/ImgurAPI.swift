//
//  ImgurAPI.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 26/05/21.
//

import Foundation

// MARK: - ImgurAPI
struct ImgurAPI: Codable {
    let data: Imgur
    let success: Bool
    let status: Int
}

// MARK: - DataClass
struct Imgur: Codable {
    let link: String
}
