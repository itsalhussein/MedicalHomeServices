//
// MedicalServiceSheetViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import Combine

class MedicalServiceSheetViewModel : BaseViewModel {
    var successSubject = PassthroughSubject<ServiceRequestModel,Never>()
    
    @MainActor
    func requestService(serviceId:Int) async {
        state.startLoading()
        do {
            let userLocation = AppSettings.shared.userLocation
            let currentUser = AppSettings.shared.currentUser
            let request = ServiceRequestModel(requestID: nil,
                                              longitude: userLocation?.longitude,
                                              latitude: userLocation?.latitude,
                                              serviceID: serviceId,
                                              appUserID: currentUser?.userID)
            
            let route = APIRouter.ServiceRequest(request)
            let response : ServiceRequestModel?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                successSubject.send(response)
            }
            self.state.endLoading()
            error = nil
        } catch {
            self.error = error
            
        }
        state.endLoading()
    }
}
