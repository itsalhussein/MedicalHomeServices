//
// LoadingState.swift
//
// Created by Hussein Anwar.
//

import Foundation
import SwiftUI

struct LoadingState {
    var isLoading: Bool = false
    var error: String?
    var loadingText: LocalizedStringKey?

    func canLoad() -> Bool {
        isLoading != true
    }

    mutating func startLoading(text: LocalizedStringKey? = nil) {
        loadingText = text
        error = nil
        isLoading = true
    }
    mutating func endLoading() {
        loadingText = nil
        isLoading = false
    }
}
