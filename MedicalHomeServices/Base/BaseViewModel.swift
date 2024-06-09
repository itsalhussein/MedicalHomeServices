//
// BaseViewModel.swift
// splus-v3-ios
//
// Created by Hussein Anwar.
//


import Foundation
import SwiftUI
import Combine

class BaseViewModel : ObservableObject {
    @Published var navPath = NavigationPath()
    @Published var state = LoadingState()
    @Published var error: Error?
    var cancellables: Set<AnyCancellable> = []
}
