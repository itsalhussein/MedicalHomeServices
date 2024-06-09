//
// MainTabBar.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

struct MainTabBar: View {
    
    enum MainTabs: Hashable, CaseIterable {
        case Home
        case Profile
    }
    
    @EnvironmentObject var appState: AppSettings
    @State private var selection = MainTabs.Home
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            HomeView()
                .tabItem {
                    Label(selection == .Home ?  LocalizedStringKey("Home") : "", image: selection == .Home ? "ic_home_tab_selected" : "ic_home_tab")
                        .currentAppFont(weight: .semibold)
                }
                .tag(MainTabs.Home)
            
            ProfileView()
                .tabItem {
                    Label(selection == .Profile ? LocalizedStringKey("Profile") : "", image: selection == .Profile ? "ic_more_tab_selected" : "ic_more_tab")
                        .currentAppFont(weight: .semibold)
                }
                .tag(MainTabs.Profile)
            
        }
        .tint(.primaryColor)
        .frame(minWidth: 0, maxWidth: .infinity)
        
    }
}

#Preview {
    MainTabBar()
}
