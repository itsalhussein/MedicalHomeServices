//
// WelcomeView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct WelcomeView: View {
    @State var navigateToSignUp : Bool = false
    @State var navigateToLogIn : Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 60) // For spacing from top
                
                // Logo and Title
                VStack(spacing: 10) {
                    Image("logoWithoutName")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .foregroundColor(.accent)
                    
                    Text("Medical Home Services")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                }
                
                Spacer().frame(height: 20)
                
                // Description
                Text("Welcome to Medical Home Services! We provide top-notch medical care in the comfort of your home. Our team of professionals is dedicated to your health and well-being.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                // Buttons
                VStack(spacing: 20) {
                    CustomButton(title: "Log In",
                                 foregroundColor: .white,
                                 backgroundColor: .accent,
                                 action: {
                        // Action for Log In
                        navigateToLogIn.toggle()
                    })
                    
                    CustomButton(title: "Sign Up",
                                 foregroundColor: .accent,
                                 backgroundColor: .accent.opacity(0.5),
                                 action: {
                        // Action for Sign Up
                        navigateToSignUp.toggle()
                    })
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .navigationDestination(isPresented: $navigateToLogIn) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $navigateToSignUp) {
                SignUpView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    WelcomeView()
}
