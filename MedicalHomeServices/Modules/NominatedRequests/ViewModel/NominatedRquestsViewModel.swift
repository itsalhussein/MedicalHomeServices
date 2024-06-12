//
// NominatedRquestsViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import Combine

class NominatedRequestsViewModel : BaseViewModel {
    @Published var requests :[NominatedRequestModel]? = []
    @Published var hasRequests = false
    @Published var selectedRequestId : Int?
    @Published var isFetchingRequests = false

    
    var timer: AnyCancellable?

    public func startFetchingRequests(){
        isFetchingRequests = true
        
        Task {
            await fetchNominatedRequests()
        }
        
        timer = Timer.publish(every: 5, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        Task {
                            await self.fetchNominatedRequests()
                        }
                    }
    }
    
    func stopFetchingProviders() {
        timer?.cancel()
    }

    @MainActor
    func fetchNominatedRequests() async {
        state.startLoading()
        do {
            let providerId = AppSettings.shared.currentUser?.userID
            let route = APIRouter.ProviderNominatedRequests(providerId ?? 0)
            let response : NominatedRequestResponse?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                if let requests = response.nominatedRequests {
                    if !requests.isEmpty {
                        hasRequests = true
                    }
                    self.requests = requests
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
