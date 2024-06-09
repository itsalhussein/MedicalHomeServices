//
// UIColor+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//

// MARK: - UIKit
import UIKit

extension UIColor {
    static let primaryColor      = UIColor(named: "AccentColor")!
    static let secondaryColor   = UIColor(named: "AccentSubColor")!
    
    static let borderColor      = UIColor(named: "BorderColor")!
    static let textColor        = UIColor(named: "TextColor")!
    static let textLightColor   = UIColor(named: "TextLightColor")!
    static let viewBGColor      = UIColor(named: "ViewBGColor")!
    static let componentBGColor = UIColor(named: "ComponentBGColor")!
    

    static let greenColor       = UIColor(named: "GreenColor")!
    static let redColor         = UIColor(named: "RedColor")!
}

extension UIColor {
    /// The SwiftUI color associated with the receiver.
    var suColor: Color { Color(self) }
}

extension UIColor {
    class func fromHex(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        var hexNumber: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&hexNumber)

        if cString.count == 6 {
            r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
            g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
            b = CGFloat(hexNumber & 0x0000FF) / 255
            a = CGFloat(1.0)

            self.init(red: r, green: g, blue: b, alpha: a)

        } else if cString.count == 8 {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
            
            self.init(red: r, green: g, blue: b, alpha: a)

        } else {
            return nil
            
        }

    }
}

// MARK: - SwiftUI
import SwiftUI

extension Color {
    static let primaryColor      = Color("AccentColor")
    static let secondaryColor   = Color("AccentSubColor")
    
    static let borderColor      = Color("BorderColor")
    static let textColor        = Color("TextColor")
    static let textLightColor   = Color("TextLightColor")
    static let viewBGColor      = Color("ViewBGColor")
    static let componentBGColor = Color("ComponentBGColor")

    static let greenColor       = Color("GreenColor")
    static let redColor         = Color("RedColor")
}


extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}


extension Color {
    init(hexStr: String) {
        let hex = hexStr.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
