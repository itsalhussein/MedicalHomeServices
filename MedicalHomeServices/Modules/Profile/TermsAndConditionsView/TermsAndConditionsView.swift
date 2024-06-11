//
// TermsAndConditionsView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

struct TermsAndConditionsView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Terms and Conditions")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16,height: 16)
                        .foregroundStyle(.black)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    
                }
                
                
                Text("By using this app, you agree to the following terms and conditions:")
                    .font(.headline)
                
                Text("1. You must be at least 18 years old to use this app.")
                Text("2. You agree to use this app responsibly and lawfully.")
                Text("3. We reserve the right to modify or terminate the app at any time.")
                Text("4. Your use of the app is at your sole risk. We are not responsible for any damages.")
                Text("5. Your personal information may be collected and used as described in our Privacy Policy.")
                Text("6. We may update these terms and conditions from time to time. Please review them periodically.")
                
                Spacer()
            }
            .padding()
        }
//        .navigationBarTitle("Terms and Conditions", displayMode: .inline)
    }
}

struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView()
    }
}
