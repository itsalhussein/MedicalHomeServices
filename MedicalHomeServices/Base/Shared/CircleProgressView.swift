//
// CircleProgressView.swift
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI

struct CircleProgressView: View {

    @State var appear = false
    
    var color: Color = .primaryColor
    var size = 18.0

    var body: some View {
//        ProgressView()
//            .progressViewStyle(.circular)
//            .controlSize(size)
//            .foregroundColor(color)
         Circle()
             .trim(from: 0.2, to: 1)
             .stroke(color, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
             .frame(width: size, height: size, alignment: .center)
             .rotationEffect(Angle(degrees: appear ? 360 : 0))
             .animation(
                 Animation
                     .linear(duration: 1.8)
                     .repeatForever(autoreverses: false),
                 value: appear
             )
//             .transition(.f)
             .onAppear {
                 appear = true
             }
    }
}

#Preview {
    CircleProgressView()
}
