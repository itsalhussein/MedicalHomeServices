//
//  UIButton+Extention.swift
//  Safer Resident
//
//  Created by Ramy Sabry on 26/05/2021.
//  Copyright © 2021 Ramy Ayman Sabry. All rights reserved.
//

import UIKit


@IBDesignable extension UIButton {
    @IBInspectable var localizedText: String? {
        set {
            self.setTitle(newValue?.localized, for: .normal)
        }
        get {
            return titleLabel?.text?.localized
        }
    }
}
