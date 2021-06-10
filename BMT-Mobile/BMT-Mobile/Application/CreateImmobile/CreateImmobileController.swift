//
//  CreateImmobileController.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 26/05/21.
//

import UIKit

protocol CreateImmobileControllerDelegate {
    func completionUploadImgur(result: String)
    func sucessCreated()
    func failedCreated(error: NSError)
}

class CreateImmobileController {
    
    var delegate: CreateImmobileControllerDelegate?
    
    func uploadToImgur(image: UIImage) {
        ApiManager().uploadImgur(image: image) { link, error in
            self.delegate?.completionUploadImgur(result: link ?? "")
        }
    }
    
    func createImmobile(immobile: Immobile) {
        ApiManager().createImobile(imobile: immobile) { sucess, error in
            if sucess {
                self.delegate?.sucessCreated()
                return
            }
            self.delegate?.failedCreated(error: error!)
        }
    }
}

