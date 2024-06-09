//
//  ToastItemType.swift
//  Safer Resident
//
//  Created by Ramy Sabry on 17/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import Foundation
import UIKit

enum ToastItemType {
    case error
    case alert
    case success
}

extension ToastItemType {
    var color: UIColor {
        switch self {
        case .error:
            return UIColor.black
            
        case .alert:
            return UIColor.black
            
        case .success:
            return UIColor.green
        }
    }
}
