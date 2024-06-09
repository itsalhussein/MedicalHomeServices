//
//  UIWindowScene+Extension.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 02/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

extension UIWindowScene {
    static var current: UIWindowScene? {
        UIApplication.shared.connectedScenes.first(
            where: { $0.activationState == .foregroundActive }
        ) as? UIWindowScene
    }
}
