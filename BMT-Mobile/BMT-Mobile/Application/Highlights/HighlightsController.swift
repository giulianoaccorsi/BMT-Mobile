//
//  HighlightsController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 01/10/21.
//

import Foundation

protocol HighlightsControllerDelegate {
    func show(immobile: [Immobile])
}

class HighlightsController {
    
    var delegate: HighlightsControllerDelegate?
    
    func getImmobile(token: String) {
        ApiManager().getAllImmobiles(token: token) { immobileList, error in
            if let list = immobileList {
                self.delegate?.show(immobile: list)
            }
        }
    }
}
