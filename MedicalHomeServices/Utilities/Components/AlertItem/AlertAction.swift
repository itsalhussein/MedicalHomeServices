//
//  AlertAction.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 03/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

struct AlertAction {
    typealias Action = () -> Void
    
    let title: String
    let style: UIAlertAction.Style
    var action: Action?

    init(
        title: String,
        style: UIAlertAction.Style = .default,
        action: Action?
    ) {
        self.title = title
        self.style = style
        self.action = action
    }
}

extension AlertAction {
    var toUIAlertAction: UIAlertAction {
        UIAlertAction(
            title: title.localized,
            style: style
        ) { _ in
            self.action?()
        }
    }
}
