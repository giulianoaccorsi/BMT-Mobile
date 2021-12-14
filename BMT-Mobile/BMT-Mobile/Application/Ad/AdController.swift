//
//  AdController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 23/05/21.
//

import Foundation

protocol AdControllerDelegate {
    func show(immobile: [Immobile])
}

class AdController {
    
    var delegate: AdControllerDelegate?
    
    func getImmobile(token: String) {
        ApiManager().getAllImmobiles(token: token) { immobileList, error in
            if let list = immobileList {
                self.delegate?.show(immobile: list)
            }
        }
    }
}
