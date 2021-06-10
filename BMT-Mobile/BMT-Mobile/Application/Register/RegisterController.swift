//
//  RegisterController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 24/05/21.
//

import Foundation

protocol RegisterControllerDelegate {
    func sucessRegistration(result: Bool)
    func failedToRegister(error: NSError)
}

class RegisterController {
    
    var delegate: RegisterControllerDelegate?
    
    func registerUser(user: User) {
        ApiManager().isRegisterSucess(user: user) { sucess, error in
            if let errorAPI = error {
                self.delegate?.failedToRegister(error: errorAPI)
                return
            }
            self.delegate?.sucessRegistration(result: sucess)
        }
    }
}

