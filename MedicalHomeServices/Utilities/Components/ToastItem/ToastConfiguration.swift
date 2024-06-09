//
//  ToastConfiguration.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 03/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

protocol ToastConfiguration {
    var duration: TimeInterval { get set }
    var fadeInDelay: TimeInterval { get set }
    var fadeOutDelay: TimeInterval { get set }
    var fadeInOptions: UIView.AnimationOptions { get set }
    var fadeOutOptions: UIView.AnimationOptions { get set }
}

struct BaseToastConfiguration: ToastConfiguration {
    var duration: TimeInterval = 1.0
    var fadeInDelay: TimeInterval = 0.0
    var fadeOutDelay: TimeInterval = 2.0
    var delay: TimeInterval = 2.0
    var fadeInOptions: UIView.AnimationOptions = [.curveEaseOut, .allowUserInteraction]
    var fadeOutOptions: UIView.AnimationOptions = [.curveEaseIn, .beginFromCurrentState]
}
