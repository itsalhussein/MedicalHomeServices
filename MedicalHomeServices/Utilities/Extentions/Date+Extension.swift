//
//  Date+Extension.swift
//  MyIdentity
//
//  Created by Ramy Sabry on 01/11/2023.
//  Copyright © 2023 Ramy Ayman Sabry. All rights reserved.
//

import Foundation

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
}
