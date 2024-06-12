//
// SwitchToProviderSheetViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import Combine

class SwitchToProviderSheetViewModel : BaseViewModel {
    let providerID = AppSettings.shared.currentUser?.userID
    @Published var medicalServices : [MedicalService] = []
    @Published var selectedServices : [MedicalService] = []
    @Published var userPreSelectedServices : [UserServiceModel] = []
    var successSubject = PassthroughSubject<Void,Never>()
    
    public func filterMedicalServices(){
        medicalServices = medicalServices.filter { medicalService in
            !userPreSelectedServices.contains { userService in
                userService.serviceID == medicalService.id
            }
        }
    }

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
    
    @MainActor
    func getUserServices() async {
        state.startLoading()
        do {
            guard let userID = AppSettings.shared.currentUser?.userID else { return }
            let route = APIRouter.GetUserServices(userID)
            let response : [UserServiceModel]?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                userPreSelectedServices = response
                filterMedicalServices()
            }
            error = nil
        } catch {
            self.error = error
            
        }
        state.endLoading()
    }
    
    
    @MainActor
    func switchToProvider() async {
        state.startLoading()
        do {
            let request = selectedServices.map { service -> AddUserToProviderRequestModel in
                return .init(providerID: providerID, serviceID: service.id)
            }
            let route = APIRouter.AddUserToProviderRequest(request)
            let response : String?
            response = try await APIService.shared.fetch(route: route)
            successSubject.send(())
            error = nil
        } catch {
            self.error = error
            successSubject.send(())
        }
        state.endLoading()
    }
    
}
