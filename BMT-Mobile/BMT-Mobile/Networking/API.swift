//
//  API.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import Foundation

struct API {
    static var baseURL: String = "https://flask-login-api.herokuapp.com/api"
    static var users: String = "/users"
    static var tokenUser: String = "/tokens"
    static var solicitationReset: String = "/reset_password_request"
    static var resetPassword: String = "/verify_password_token"
    static var imoveis: String = "/ads"
}
