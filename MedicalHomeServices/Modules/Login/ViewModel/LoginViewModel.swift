//
// LoginViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import SwiftUI
import Combine
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageSVGCoder

class LoginViewModel : BaseViewModel {
    @Published var mobileNumber: String = ""
    @Published var password: String = ""
    var successSubject = PassthroughSubject<Void,Never>()

    @MainActor
    func signIn() async {
        state.startLoading()
        do {
            let request = SignInRequest(mobileNumber: mobileNumber, password: password, fullName: nil, email: nil, dateOfBirth: nil)
            let route = APIRouter.Login(request)
            let response : UserRepsonse?
            response = try await APIService.shared.fetch(route: route)
            
            if let token = response?.token {
                AppSettings.shared.currentUser = response
                AppSettings.shared.accessToken = token
            }
            
            let imageDownloader = SDWebImageDownloader.shared
            imageDownloader.setValue(AppSettings.shared.accessToken, forHTTPHeaderField: "Token")
            successSubject.send(())
            self.state.endLoading()
            error = nil
        } catch {
            self.error = error
            
        }
        state.endLoading()
    }
}

