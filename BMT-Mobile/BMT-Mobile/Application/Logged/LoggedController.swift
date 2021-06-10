//
//  LoggedController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import Foundation

protocol LoggedControllerDelegate {
    func show(immobile: [Immobile])
}

class LoggedController {
    
    var delegate: LoggedControllerDelegate?
    
    func getImmobile(token: String) {
        ApiManager().getAllImmobiles(token: token) { immobileList, error in
            if let list = immobileList {
                self.delegate?.show(immobile: list)
            }
        }
    }
}
