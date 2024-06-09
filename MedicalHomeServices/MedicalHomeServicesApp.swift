//
// MedicalHomeServicesApp.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI
import SDWebImageSwiftUI
import SDWebImageSVGCoder
import netfox
import IQKeyboardManagerSwift

@main
struct MedicalHomeServicesApp: App {
    @StateObject var appState = AppSettings.shared
    
    init() {
        let imageDownloader = SDWebImageDownloader.shared
        if let token = AppSettings.shared.accessToken {
            imageDownloader.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    //        #if DEBUG
        NFX.sharedInstance().start()
    //        #endif
        setupKeyboardManager()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .id(appState.rootViewId)
        }
    }
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = true
        IQKeyboardManager.shared.toolbarConfiguration.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.enableAutoToolbar = true
    }

}
