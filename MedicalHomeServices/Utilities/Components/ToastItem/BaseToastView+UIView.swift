//
//  BaseToastView+UIView.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 03/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

extension UIView {
    func showToast(
        _ message: String,
        backgroundColor: UIColor,
        configuration: ToastConfiguration,
        onClose: @escaping () -> Void
    ) {
        let toastView = createToastView(
            for: message,
            backgroundColor: backgroundColor
        )
        
        UIView
            .animate(
                withDuration: configuration.duration,
                delay: configuration.fadeInDelay,
                options: configuration.fadeInOptions,
                animations: {
                    toastView.alpha = 1.0
                },
                completion: { [weak self] _ in
                    self?.hideToast(
                        toastView: toastView,
                        configuration: configuration,
                        onClose: onClose
                    )
                }
            ) //: Showing Toast
    }
}

private extension UIView {
    func createToastView(for message: String, backgroundColor: UIColor) -> BaseToastView {
        let toastView = BaseToastView()
        toastView.setMessage(message)
        toastView.setBackgroundColor(to: backgroundColor)
        toastView.alpha = 0.0
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(toastView)
        
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            toastView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            toastView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        return toastView
    }
    
    func hideToast(
        toastView: BaseToastView,
        configuration: ToastConfiguration,
        onClose: @escaping () -> Void
    ) {
        UIView
            .animate(
                withDuration: configuration.duration,
                delay: configuration.fadeOutDelay,
                options: configuration.fadeOutOptions,
                animations: {
                    toastView.alpha = 0.0
                },
                completion: { _ in
                    toastView.removeFromSuperview()
                    onClose()
                }
            ) //: Hiding Toast
    }
}
