//
//  UIApplication+Extension.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 02/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

extension UIApplication {
    var topController: UIViewController? {
        let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        guard var topController = keyWindow?.rootViewController else { return nil }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        return topController
    }
    
    var window: UIWindow? {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    }
}

extension UIApplication {
    // MARK: - BaseToastView
    func showToast(
        _ message: String,
        backgroundColor: UIColor,
        configuration: ToastConfiguration = BaseToastConfiguration(),
        onClose: @escaping () -> Void
    ) {
        window?.showToast(
            message,
            backgroundColor: backgroundColor,
            configuration: configuration,
            onClose: onClose
        )
    }
    
    // MARK: - AlertView
    func showAlertView(
        _ alertData: AlertItem,
        completion: @escaping () -> Void
    ) {
        guard let topController = topController,
              !(topController is UIAlertController)
        else {
            return
        }
        
        let alert = UIAlertController(
            title: alertData.title?.localized,
            message: alertData.message?.localized,
            preferredStyle: alertData.style
        )
        for action in alertData.actions {
            alert.addAction(action.toUIAlertAction)
        }
        topController.present(alert, animated: true, completion: completion)
    }
    
}

