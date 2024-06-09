//
// SplashView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appSettings : AppSettings
    var body: some View {
        VStack {
            Spacer()
            Image("mhs-logo")
                .resizable()
                .frame(width: 350,height: 350)
            Spacer()
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute:{
                appSettings.setNextMainScreen()
            })
        })
    }
}

#Preview {
    SplashView()
        .environmentObject(AppSettings())
}
