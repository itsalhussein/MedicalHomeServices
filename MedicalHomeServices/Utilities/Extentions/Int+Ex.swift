//
// Float+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import Foundation

extension Int {
    func max2FractionDigits() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.locale = .init(identifier: "en_us")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return String(formatter.string(from: number) ?? "")
    }
}
