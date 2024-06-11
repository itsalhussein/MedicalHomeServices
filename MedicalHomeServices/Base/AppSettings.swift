//
//  AppSettings.swift
//  Ekhtesrha
//
//  Created by Hussein Anwar on 22/11/2023.
//

import UIKit
import SwiftUI

final class AppSettings: ObservableObject {
    // MARK: - Enums
    enum Status {
        case loading
        case home
        case notLoggedIn
    }
    
    enum AppLang:String {
        case ar = "ar"
        case en = "en"
    }
    
    // MARK: - Published Variables
    @Published var rootViewId = UUID()
    @Published var appStatus: Status = .loading
    @Published var local = Locale(identifier: AppLang.ar.rawValue)
    @Published var layoutDirection = LayoutDirection.rightToLeft
    @Published var colorScheme = ColorScheme.light
    @Published var error: Error?

    // MARK: - AppStorage Variables
    @AppStorage("currentLang") var currentLang = AppLang.en
    @AppStorage("currentUser") var currentUser:UserRepsonse?
    @AppStorage("accessToken") var accessToken:String?
    @AppStorage("cacheSession") var cacheSession:String?
    @AppStorage("userLocation") var userLocation:MHSUserLocation?

    
    // MARK: - Init
    init() {
        layoutDirection = currentLang == .ar ? LayoutDirection.rightToLeft : LayoutDirection.leftToRight
        local = Locale(identifier: currentLang.rawValue)
    }

    
    // MARK: - Computed Values
    var isLoggedIn: Bool {
        return (accessToken != nil && currentUser != nil)
    }
    
    
    // MARK: - Methods
    func resetUserSettings() {
        accessToken = nil
        currentUser = nil
    }
    func logOut(){
        resetUserSettings()
        appStatus = .notLoggedIn
        rootViewId = UUID()
    }
    func setNextMainScreen(){
        if currentUser == nil {
            appStatus = .notLoggedIn
        }else{
            appStatus = .home
        }
    }
    
    func isProvider() -> Bool {
        guard let roles = currentUser?.roles else { return false }
        return roles.contains("Provider")
    }
    

    // MARK: - Private
    static let shared = AppSettings()

    func switchLanguage(){
        if currentLang == .ar {
            currentLang = .en
        }else{
            currentLang = .ar
        }
        layoutDirection = currentLang == .ar ? .rightToLeft : .leftToRight
        local = Locale(identifier: currentLang.rawValue)
    }
    
}
