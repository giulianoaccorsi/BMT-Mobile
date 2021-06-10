//
//  ViewConfigurationProtocol.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 22/05/21.
//

import Foundation

protocol ViewConfiguration {
    func buildViewHierarchy()
    func setUpConstraints()
    func setUpAdditionalConfiguration()
    func setUpView()
}

extension ViewConfiguration {
    func setUpView() {
        buildViewHierarchy()
        setUpConstraints()
        setUpAdditionalConfiguration()
    }
}
