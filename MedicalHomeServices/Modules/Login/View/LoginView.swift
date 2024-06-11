//
// LoginView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI
import Combine
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageSVGCoder

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State var navigateToSignUp : Bool = false
    @State var navigateToHome : Bool = false
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Spacer().frame(height: 40) // For spacing from top
                VStack{
                    Text("Hello!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.accent)

                    Spacer().frame(height: 10)
                    Text("Welcome")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                }
                Spacer().frame(height: 30)
                
                CustomInputField(title: "Mobile Number", placeholder: "0x0xxxxxxxxx", text: $viewModel.mobileNumber)

                CustomInputField(title: "Password", placeholder: "********", text: $viewModel.password, isSecure: true)

//                HStack {
//                    Spacer()
//                    Button(action: {
//                        // Action for forget password
//                    }) {
//                        Text("Forget Password")
//                            .font(.footnote)
//                            .foregroundColor(.accent)
//                    }
//                }
            }
            .padding(.horizontal, 30)

            Spacer().frame(height: 30)

            CustomButton(title: viewModel.state.isLoading ? "" : "Log In",
                         foregroundColor: .white,
                         backgroundColor: .accent,
                         action: {
                // Action for login
                Task {
                    await viewModel.signIn()
                }
                
            })
            .padding(.horizontal, 30)
            .buttonStyle(LoadingButtonStyle(isLoading: viewModel.state.isLoading, color: .clear))

            Spacer().frame(height: 20)

            Text("or")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer().frame(height: 20)

            HStack {
                Text("Don’t have an account?")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Button(action: {
                    // Action for sign up
                    navigateToSignUp.toggle()
                }) {
                    Text("Sign Up")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.accent)
                }
            }

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            // Action for back button
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.accent)
        })
        .navigationDestination(isPresented: $navigateToSignUp) {
            SignUpView()
                .navigationBarBackButtonHidden()
        }
        .navigationDestination(isPresented: $navigateToHome) {
            MainTabBar()
                .navigationBarBackButtonHidden()
        }
        
        .onReceive(viewModel.successSubject, perform: { _ in
            navigateToHome.toggle()
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
