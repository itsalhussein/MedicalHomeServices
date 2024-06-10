//
// SignUpViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import Combine

class SignUpViewModel: BaseViewModel {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var mobileNumber: String = ""
    @Published var dateOfBirth: String = ""
    var successSubject = PassthroughSubject<Void,Never>()

    @MainActor
    func signUp() async {
        state.startLoading()
        do {
            let request = SignUpRequest(mobileNumber: mobileNumber, password: password, fullName: fullName, email: email, dateOfBirth: dateOfBirth)
            let route = APIRouter.Register(request)
            let response : UserRepsonse?
            response = try await APIService.shared.fetch(route: route)
            Helper.showBanner(title: "Registration Successful!")
            successSubject.send(())
            self.state.endLoading()
            error = nil
        } catch {
            self.error = error
        }
        state.endLoading()
    }
}
