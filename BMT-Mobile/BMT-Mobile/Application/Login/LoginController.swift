//
//  LoginController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 25/05/21.
//


import Foundation

class LoginController {
    
    func isTokenActive(email: String, password: String, completion: @escaping (String?, NSError?)->Void) {
        ApiManager().loginUser(email: email, password: password) { token, error  in
            if let errorAPI = error {
                completion(nil, errorAPI)
                return
            }
            SessionManagerUser.shared.token = token
            completion(token, nil)
        }
    }
}


