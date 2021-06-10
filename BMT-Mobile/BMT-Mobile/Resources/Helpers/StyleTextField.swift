//
//  StyleTextField.swift
//  BMT-Mobile
//
//  Created by Giuliano Accorsi on 22/05/21.
//

import Foundation
import FormTextField

struct CustomStyle {
    static func apply() {
        let enabledBackgroundColor = UIColor.white
        let enabledBorderColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0)
        let enabledTextColor = UIColor(red: 0.271, green: 0.361, blue: 0.451, alpha: 1.0)
        let activeBorderColor = UIColor(red: 0.439, green: 0.843, blue: 1.0, alpha: 1.0)

        FormTextField.appearance().borderWidth = 1
        FormTextField.appearance().cornerRadius = 0
        FormTextField.appearance().clearButtonColor = activeBorderColor
        FormTextField.appearance().font = UIFont(name: "AvenirNext-Regular", size: 15)!

        FormTextField.appearance().enabledBackgroundColor = enabledBackgroundColor
        FormTextField.appearance().enabledBorderColor = enabledBorderColor
        FormTextField.appearance().enabledTextColor = enabledTextColor

        FormTextField.appearance().validBackgroundColor = enabledBackgroundColor
        FormTextField.appearance().validBorderColor = enabledBorderColor
        FormTextField.appearance().validTextColor = enabledTextColor

        FormTextField.appearance().activeBackgroundColor = enabledBackgroundColor
        FormTextField.appearance().activeBorderColor = activeBorderColor
        FormTextField.appearance().activeTextColor = enabledTextColor

        FormTextField.appearance().inactiveBackgroundColor = enabledBackgroundColor
        FormTextField.appearance().inactiveBorderColor = enabledBorderColor
        FormTextField.appearance().inactiveTextColor = enabledTextColor

        FormTextField.appearance().disabledBackgroundColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0)
        FormTextField.appearance().disabledBorderColor = UIColor(red: 0.875, green: 0.875, blue: 0.875, alpha: 1.0)
        FormTextField.appearance().disabledTextColor = UIColor.white

        FormTextField.appearance().invalidBackgroundColor = UIColor(red: 1.0, green: 0.788, blue: 0.784, alpha: 1.0)
        FormTextField.appearance().invalidBorderColor = UIColor(red: 1.0, green: 0.294, blue: 0.278, alpha: 1.0)
        FormTextField.appearance().invalidTextColor = UIColor(red: 1.0, green: 0.294, blue: 0.278, alpha: 1.0)
    }
}
