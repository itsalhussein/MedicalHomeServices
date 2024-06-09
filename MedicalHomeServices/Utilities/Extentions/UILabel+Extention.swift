//
//  UILabel+Extention.swift
//  Safer Resident
//
//  Created by Ramy Sabry on 26/05/2021.
//  Copyright © 2021 Ramy Ayman Sabry. All rights reserved.
//

import UIKit


@IBDesignable extension UILabel {
    @IBInspectable var localizedText: String? {
        set {
            self.text = newValue?.localized
        }
        get {
            return text?.localized
        }
    }
}
