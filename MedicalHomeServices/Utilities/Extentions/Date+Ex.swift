//
// Date+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import Foundation


extension Date{
    
    func toString(formate:String = "dd-MM-yyyy")->String?{
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = formate
        return formatter.string(from: self)
    }
}
