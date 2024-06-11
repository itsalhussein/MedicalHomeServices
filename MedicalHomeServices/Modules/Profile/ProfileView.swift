//
// ProfileView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct ProfileView: View {
    @StateObject private var appSettings = AppSettings.shared
    @State var showSwitchToProviderSheet = false
    @State var showTerms = false
    @State var showAboutUs = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Circular profile picture
                Image(appSettings.isProvider() ? "provider" : "customer")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 1)
                    .padding(.top, 50)
                    .foregroundStyle(.gray)
                
                // Segments
                VStack(spacing: 15) {
                    Text("Switch To Provider")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.accent)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .onTapGesture {
                                    showSwitchToProviderSheet.toggle()
                                }
                        
                    
    //                Text("My Profile")
    //                    .frame(maxWidth: .infinity)
    //                    .padding()
    //                    .background(Color.init(hexStr: "#1D2F6F"))
    //                    .foregroundColor(.white)
    //                    .cornerRadius(10)
                    
                    Text("Terms and Conditions")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.init(hexStr: "#1D2F6F"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            showTerms.toggle()
                        }
                    
                    Text("About Us")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.init(hexStr: "#1D2F6F"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            showAboutUs.toggle()
                        }
                    
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .onTapGesture {
                            appSettings.logOut()
                        }
                }
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .navigationBarTitle("Profile", displayMode: .inline)
            .sheet(isPresented: $showSwitchToProviderSheet, content: {
                SwitchToProviderSheet()
                    .presentationDetents([.fraction(0.9)])
            })
            .navigationDestination(isPresented: $showTerms, destination: {
                TermsAndConditionsView()
                    .navigationBarBackButtonHidden()
            })
            .navigationDestination(isPresented: $showAboutUs, destination: {
                AboutUsView()
                    .navigationBarBackButtonHidden()
            })
        }
    }
}

#Preview {
    ProfileView()
}
