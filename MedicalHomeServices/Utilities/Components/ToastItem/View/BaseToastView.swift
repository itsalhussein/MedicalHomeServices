//
//  BaseToastView.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 03/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class BaseToastView: UIView {
    private let xib: String = "BaseToastView"
    private let padding: CGFloat = 16.0
    private let viewCornerRadius: CGFloat = 8.0
    
    @IBOutlet private var toastView: UIView!
    @IBOutlet private var toastLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        toastView.layer.masksToBounds = false
        toastView.layer.cornerRadius = viewCornerRadius
    }
    
    func setMessage(_ message: String) {
        toastLabel.text = message
    }
    
    func setBackgroundColor(to color: UIColor) {
        backgroundColor = color
        toastView.backgroundColor = color
    }

    private func commonInit() {
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        
        toastView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(toastView)
        
        toastView.frame = self.bounds
        toastView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            toastView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            toastView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
}
