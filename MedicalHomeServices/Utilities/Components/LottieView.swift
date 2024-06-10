//
// LottieView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.


import SwiftUI
import Lottie


struct LottieView: UIViewRepresentable {
    
    var name = "LoadingAnimation"
    var loopMode: LottieLoopMode = .loop
    

    func makeUIView(context: Context) -> LottieAnimationView {
        let view = LottieAnimationView(name: name, bundle: Bundle.main)
        view.loopMode = loopMode
        view.play()
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView()
    }
}
