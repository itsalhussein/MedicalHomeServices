//
// TimerView.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    @Published var timeRemaining: Int = 60
    var timer: AnyCancellable?
    
    func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.cancel()
                }
            }
    }
    
    func stopTimer() {
        timer?.cancel()
    }
}

struct TimerView: View {
    @StateObject var viewModel = TimerViewModel()
    var tiemOutClosure: () -> Void

    var body: some View {
        VStack {
            Text("Please wait while we search for a service provider for your request.")
                .multilineTextAlignment(.center)
                .padding()
            Text(timeString(from: viewModel.timeRemaining))
                .font(.largeTitle)
                .padding()
                .foregroundColor(timerColor(for: viewModel.timeRemaining))
            Spacer()
        }
        .onAppear {
            viewModel.startTimer()
        }
        .onChange(of: viewModel.timeRemaining) { oldValue,newValue in
            if newValue == 0 {
                tiemOutClosure()
            }
        }
        .navigationBarHidden(true)
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func timerColor(for seconds: Int) -> Color {
        if seconds > 30 {
            return .green
        } else if seconds > 10 {
            return .yellow
        } else {
            return .red
        }
    }
}
