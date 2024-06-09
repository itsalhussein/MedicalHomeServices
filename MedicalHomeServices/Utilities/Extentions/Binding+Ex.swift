//
// Binding+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

extension Binding {
    func presence<T>() -> Binding<Bool> where Value == Optional<T> {
        return .init {
            self.wrappedValue != nil
        } set: { newValue in
            precondition(newValue == false)
            self.wrappedValue = nil
        }
    }
}

// MARK: - Optional
extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

extension NSAttributedString {
    var isEmpty: Bool {
        string.count == 0
    }
}
extension Optional where Wrapped == NSAttributedString {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}

extension String {
    var withPlaceholder: String {
        self.isEmpty ? "-" : self
    }

}

extension Optional where Wrapped == String {
    var withPlaceholder: String {
        self.isNilOrEmpty ? "-" : self!
    }
}


// MARK: - Optional Bool

extension Bool {
    var isTrue: Bool {
        self == true
    }
    var isFalse: Bool {
        self == false
    }
}

extension Optional where Wrapped == Bool {
    var isTrue: Bool {
        self == true
    }
    var isFalseOrNil: Bool {
        !isTrue
    }
}

extension NumberFormatter {
    static let floatFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter
    }()
    static let float2Formatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter
    }()
    static let floatCurrencyFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        return formatter
    }()
}


extension Numeric {
    var formattedString: String {
        NumberFormatter.floatFormatter.string(for: self) ?? "\(self)"
    }
    var formatted2String: String {
        NumberFormatter.float2Formatter.string(for: self) ?? "\(self)"
    }
    var formattedCurrencyString: String {
        NumberFormatter.floatCurrencyFormatter.string(for: self) ?? "\(self)"
    }
    var formattedPercentageString: String {
        (NumberFormatter.floatFormatter.string(for: self) ?? "\(self)") + "%"
    }
    var planeString: String {
        "\(self)"
    }
}


extension Int {
    func numberFormatted() -> String {
        let number = self
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        if let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) {
            return formattedNumber
        } else {
            print("Error formatting number")
            return "\(self)"
        }
    }
}


extension Double {
    func numberFormatted() -> String {
        let number = self
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        if let formattedNumber = numberFormatter.string(from: NSNumber(value: number)) {
            return formattedNumber
        } else {
            print("Error formatting number")
            return "\(self)"
        }
    }
}

