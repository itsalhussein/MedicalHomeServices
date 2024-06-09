//
// Font+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import SwiftUI


struct AppFontName {
//    static let isArabic = Utils.getIsArabic()
    static let light = "Cairo-Light" /*isArabic ? "Cairo-Light"    : "Roboto-Light"*/
    static let regular = "Cairo-Regular"  /*isArabic ? "Cairo-Regular"  : "Roboto-Regular"*/
    static let medium = "Cairo-Medium"  /*isArabic ? "Cairo-SemiBold"  : "Roboto-Medium"*/
    static let semiBold = "Cairo-SemiBold" /*isArabic ? "Cairo-SemiBold" : "Roboto-SemiBold"*/
    static let bold = "Cairo-Bold" /*isArabic ? "Cairo-Bold"     : "Roboto-Bold"*/
}


struct AppFont: ViewModifier {
    let weight: Font.Weight
    let size: CGFloat
 
    func body(content: Content) -> some View {
        content
            .font(.custom(getFontName(weight: weight), size: size))
    }
 
    func getFontName(weight:Font.Weight)->String{
        switch weight {
        case .light:
            return AppFontName.light
        case .regular:
            return AppFontName.regular
        case .medium:
            return AppFontName.medium
        case .semibold:
            return AppFontName.semiBold
        case .bold:
            return AppFontName.bold
        default:
            return AppFontName.regular
        }
    }
}

extension View {
    func currentAppFont(weight: Font.Weight = .regular,size: CGFloat = 14) -> some View {
        modifier(AppFont(weight: weight, size: size))
    }
}
