//
//  ToastItem.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 03/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

struct ToastItem {
    var message: String
    var type: ToastItemType
}

extension ToastItem: Equatable {
    static func == (lhs: ToastItem, rhs: ToastItem) -> Bool {
        lhs.message == rhs.message
    }
}
