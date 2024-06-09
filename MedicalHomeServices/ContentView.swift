//
// ContentView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct ContentView: View {
    @StateObject private var appSettings = AppSettings.shared
    @ObservedObject private var router = Router.shared

    init() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        UINavigationBar.appearance().standardAppearance = appearance
    }

    var body: some View {
        getView()
            .animation(.default, value: appSettings.appStatus)
            .environmentObject(appSettings)
            .environmentObject(router)
            .environment(\.locale, appSettings.local)
            .environment(\.layoutDirection, appSettings.layoutDirection)
            .environment(\.colorScheme, appSettings.colorScheme)
    }

    @ViewBuilder
    func getView()-> some View{
        switch appSettings.appStatus {
        case .loading:
            SplashView()
        case .home:
            MainTabBar()
        case .notLoggedIn:
            WelcomeView()
        }
    }

}

#Preview {
    ContentView()
}

