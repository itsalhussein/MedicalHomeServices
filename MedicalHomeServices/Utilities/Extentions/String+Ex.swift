//
// String+Ex.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import UIKit
import SwiftUI

extension String {
    
    var url: URL? {
        var url: URL? = nil
        url = URL(string: self)
        if url == nil {
            let encodeString =  self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let encodeString = encodeString {
                url = URL(string: encodeString)
            }
        }
        
        if let _url = url, _url.scheme == nil {
            var components = URLComponents(url: _url, resolvingAgainstBaseURL: false)
            components?.scheme = "https"
            url = components?.url
        }
        
        return url
    }
    
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
    
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}


extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localized( _ args: CVarArg...) -> String {
        // return String.localizedStringWithFormat(self.localized, args)
        return String(format: self.localized, locale: AppSettings.shared.local, arguments: args)
    }
    
    var localizedKey: LocalizedStringKey {
        LocalizedStringKey(self)
    }
    
    func toDate(formate:String = "dd-MM-yyyy")->Date?{
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = formate
        return formatter.date(from: self)
    }
    
    
}
