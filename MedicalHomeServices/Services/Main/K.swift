//
//  K.swift
//  Snackat
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation

struct K {
    
    static var server: ServerConfig.Type = DevelopmentServer.self
    
    struct Config {
        static var appName: String = {
            Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as! String
        }()
        
        static var appVersion: String = {
            Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        }()
        
        static var buildNumber: String = {
            Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String
        }()

        private init() { }
    }

}



// MARK: - Servers

extension K {
    private struct ProductionServer: ServerConfig {
        static let url = ""
        static let apiKey = ""
        #if DEBUG
        static var testUsername = "", testPassword = ""
        #endif
    }
    private struct StagingServer: ServerConfig {
        static let url = ""
        static let apiKey = ""
        #if DEBUG
        static var testUsername = "", testPassword = ""
        #endif
    }
    private struct QCServer: ServerConfig {
        static let url = ""
        static let apiKey = ""
        #if DEBUG
        static var testUsername = "", testPassword = ""
        #endif
    }
    private struct DevelopmentServer: ServerConfig {
        static let url = "http://mhs.runasp.net/api"
        static let apiKey = ""
        #if DEBUG
        static var testUsername = "", testPassword = ""
        #endif
    }

}

protocol ServerConfig {
    static var url: String { get }
    static var apiKey: String { get }
    #if DEBUG
    static var testUsername: String { get }
    static var testPassword: String { get }
    #endif
}



extension NSNotification.Name {
    static let sample = Self("")
}
