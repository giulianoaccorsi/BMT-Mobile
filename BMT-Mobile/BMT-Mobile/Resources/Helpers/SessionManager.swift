//
//  SessionManager.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 25/05/21.
//


import Foundation

class SessionManagerUser {
    
    static let shared : SessionManagerUser = {
        let instance = SessionManagerUser()
        return instance
    }()
    
    var user: User?
    var token: String?
    
   
    func saveInUserDefault(value:  Any, key: String) {
        
        let prefs = UserDefaults.standard
        let dicSaved: [String:Any] = [key:value]
        prefs.set(dicSaved, forKey: key)
    }
    
    func deleteValueInUserDefautl(key:String){

        let prefs = UserDefaults.standard
        prefs.removeObject(forKey: key)
    }

    
    
    func clearSession() {
        self.user = nil
        self.token = nil
    }
}
