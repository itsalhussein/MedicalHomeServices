//
// HomeViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import Combine

class HomeViewModel : BaseViewModel {
    @Published var medicalServices: [MedicalService] = []
    @Published var selectedRequest: ServiceRequestModel? = nil 

    @MainActor
    func getMedicalServices() async {
        state.startLoading()
        do {
            
            let route = APIRouter.MedicalServices
            let response : [MedicalService]?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                medicalServices = response
            }
            error = nil
        } catch {
            self.error = error
            
        }
        state.endLoading()
    }
}
