//
// CustomTextFieldView.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//
import SwiftUI

struct CustomTextFieldView: View {
    //MARK: - Variables
    @Binding var value:String
    var placeholder:String
    var icon:String = ""
    var keyboardType:UIKeyboardType = .default
    var valueSize:CGFloat = 16
    var valueColor:Color = Color.textColor
    var backgroundColor:Color = Color.white
    var borderColor:Color = Color.borderColor
    var cornerRadius:CGFloat = 8
    var padding: CGFloat = 8
    
    //MARK: - Body
    var body: some View {
        
        HStack(alignment: .center) {
            if !icon.isEmpty{
                Image(icon)
                    .padding(8)
            }
            TextField(LocalizedStringKey(placeholder), text:$value)
                .currentAppFont(weight: .light,size: valueSize)
                .foregroundStyle(valueColor)
                .keyboardType(keyboardType)
        }
        .padding(padding)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: 1)
                .foregroundColor(borderColor)
        )
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

#Preview {
    CustomTextFieldView(value: .constant(""),
                        placeholder: "Username",
                            icon: "ic_userName")
//        .environment(\.locale, AppSettings.shared.local)
//        .environment(\.layoutDirection, AppSettings.shared.layoutDirection)
}
