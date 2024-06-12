//
// AboutUsView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

struct AboutUsView: View {
    @Environment(\.presentationMode) private var presentationMode

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("About Us")
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
                
                Text("Welcome to Our App!")
                    .font(.headline)
                
                Text("""
                    Our mission is to provide exceptional service and deliver high-quality products to our users. We are committed to creating a user-friendly experience and continuously improving our app to meet your needs.
                    
                    Our team is composed of dedicated professionals with diverse backgrounds in technology, design, and customer service. We work together to bring you the best possible experience.
                    
                    If you have any questions, feedback, or suggestions, please feel free to contact us. We value your input and are always looking for ways to improve.
                    
                    Thank you for choosing our app. We hope you enjoy using it as much as we enjoyed creating it!
                    """)
                
                Text("Contact Us")
                    .font(.headline)
                
//                Text("""
//                    Email: support@ourapp.com
//                    Phone: (123) 456-7890
//                    Address: 1234 App Street, Tech City, TX 12345
//                    """)
                
                Spacer()
            }
            .padding()
        }
//        .navigationBarTitle("About Us", displayMode: .inline)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
