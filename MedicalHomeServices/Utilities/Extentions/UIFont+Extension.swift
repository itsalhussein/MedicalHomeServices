//
//  UIFont+Extension.swift
//  Safer Resident
//
//  Created by Ramy Sabry on 14/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import UIKit.UIFont
import SwiftUI

extension UIFont {
    var toSwiftUIFont: Font {
        return Font(self)
    }
}
