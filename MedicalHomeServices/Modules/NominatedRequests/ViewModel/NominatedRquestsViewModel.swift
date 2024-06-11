//
// NominatedRquestsViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation

class NominatedRequestsViewModel : BaseViewModel {
    @Published var requests :[NominatedRequestModel]? = []
    @Published var hasRequests = false
    @Published var selectedRequestId : Int?
    
    @MainActor
    func fetchNominatedRequests() async {
        state.startLoading()
        do {
            let providerId = AppSettings.shared.currentUser?.userID
            let route = APIRouter.ProviderNominatedRequests(providerId ?? 0)
            let response : [NominatedRequestModel]?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                requests = response
                if !response.isEmpty {
                    hasRequests = true
                }
            }
            self.state.endLoading()
            error = nil
        } catch {
            self.error = error
        }
        state.endLoading()
    }
    
    @MainActor
    func updateProviderLocation() async {
        state.startLoading()
        do {
            let providerId = AppSettings.shared.currentUser?.userID
            let lat = AppSettings.shared.userLocation?.latitude
            let long = AppSettings.shared.userLocation?.longitude
            let request = UpdateProviderLocation(providerId: providerId, longitude: long, latitude: lat)
            let route = APIRouter.UpdateProviderLocation(request)
            let response : [NominatedRequestModel]?
            response = try await APIService.shared.fetch(route: route)
            self.state.endLoading()
            error = nil
        } catch {
            self.error = error
        }
        state.endLoading()
    }
}
