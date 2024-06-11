//
// LoadingButton.swift
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

struct LoadingButtonStyle: ButtonStyle {
    let isLoading: Bool
    let color : Color
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(isLoading ? Color.primary : .white)
            .overlay {
                if self.isLoading {
                    ActivityIndicator(color: .white)
                }
            }
            .frame(height: 43, alignment: .center)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(color)
            .font(.system(size: 16, weight: .regular))
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .animation(.spring(), value: UUID())

    }
}

struct LoadingButton: View {
    @State var isLoading = false
    let color : Color

    var body: some View {
        Button(action: { self.isLoading.toggle() }, label: {
            Text("Test")
        })
        .buttonStyle(LoadingButtonStyle(isLoading: self.isLoading, color: color))
        .disabled(isLoading)
    }
}

struct LoadingButton_Previews: PreviewProvider {
    static var previews: some View {
        LoadingButton(color: .red)
    }
}
