//
// ActivityIndicator.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import SwiftUI

struct ActivityIndicator: View {
    let color: Color

    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: color))
    }
}


struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator(color: .white)
    }
}
