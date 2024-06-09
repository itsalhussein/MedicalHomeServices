//
// CustomButtonView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI

struct CustomButton: View {
    var title: String
    var foregroundColor: Color
    var backgroundColor : Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .cornerRadius(30)
        }
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(title: "Log In",
                     foregroundColor: .white,
                     backgroundColor: .accent, action: {})
            .padding()
    }
}


struct CustomInputField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .fontWeight(.medium)
            
            HStack {
                if isSecure && !isPasswordVisible {
                    SecureField(placeholder, text: $text)
                        .padding()
                } else {
                    TextField(placeholder, text: $text)
                        .padding()
                }
                
                if isSecure {
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                            .padding(.horizontal,8)
                    }
                }
            }
            .background(Color.accentColor.opacity(0.1))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0)
            )
        }
    }
}

struct CustomInputField_Previews: PreviewProvider {
    static var previews: some View {
        CustomInputField(title: "Email or Mobile Number", placeholder: "example@example.com", text: .constant(""))
            .padding()
    }
}
