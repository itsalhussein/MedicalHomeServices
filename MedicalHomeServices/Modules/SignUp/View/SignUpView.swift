//
// SignUpView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI
import Combine
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageSVGCoder
import NotificationBannerSwift

struct SignUpView: View {
    @Environment(\.presentationMode) private var presentationMode
    @StateObject var viewModel = SignUpViewModel()
    @State var navigateToLogIn : Bool = false

    @State var showPicker = false
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading, spacing: 15) {
                        Spacer().frame(height: 10) // For spacing from top
                        Text("New Account")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.accent)
                    }
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            CustomInputField(title: "Full name", placeholder: "Full Name", text: $viewModel.fullName)
                            CustomInputField(title: "Password", placeholder: "********", text: $viewModel.password, isSecure: true)
                            CustomInputField(title: "Confirm Password", placeholder: "********", text: $viewModel.confirmPassword, isSecure: true)
                            CustomInputField(title: "Email", placeholder: "example@domain.com", text: $viewModel.email)
                            CustomInputField(title: "Mobile Number", placeholder: "0x0xxxxxxxxx", text: $viewModel.mobileNumber)
                            CustomInputField(title: "Date Of Birth", placeholder: "DD / MM / YYYY", text: $viewModel.dateOfBirth)
                                .onTapGesture {
                                    showPicker.toggle()
                                }
                        }
                    }
                    
                    Text("By continuing, you agree to our Terms of Use and Privacy Policy.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .lineLimit(2)
                }
                .padding(.horizontal, 30)

                Spacer().frame(height: 30)

                CustomButton(title: viewModel.state.isLoading ? "" : "Sign Up",
                             foregroundColor: .white,
                             backgroundColor: .accent,
                             action: {
                    // Action for sign up
                    Task {
                        await viewModel.signUp()
                    }
                })
                .padding(.horizontal, 30)
                .buttonStyle(LoadingButtonStyle(isLoading: viewModel.state.isLoading, color: .clear))

                Spacer().frame(height: 20)

                HStack {
                    Text("Already have an account?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Button(action: {
                        // Action for log in
                        navigateToLogIn.toggle()
                    }) {
                        Text("Log In")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.accent)
                    }
                }

                Spacer().frame(height: 20)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                // Action for back button
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.accent)
            })
            .navigationDestination(isPresented: $navigateToLogIn) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
            .sheet(isPresented: $showPicker, content: {
                DatePickerSheet { date in
                    viewModel.dateOfBirth = date.toString(dateFormat: "yyyy-MM-dd")
                    showPicker.toggle()
                }
                .presentationDetents([.fraction(0.45)])
            })
            .onReceive(viewModel.successSubject, perform: { _ in
                navigateToLogIn.toggle()
            })
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

