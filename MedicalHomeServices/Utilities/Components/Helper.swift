//
// Helper.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import NotificationBannerSwift

final class Helper {
    
    public static func showBanner(title: String,subtitle:String? = nil,style:BannerStyle = .success) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.show()
    }
}
