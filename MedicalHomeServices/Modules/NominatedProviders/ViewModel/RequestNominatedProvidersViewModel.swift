//
// RequestNominatedProvidersViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import Combine

class RequestNominatedProvidersViewModel : BaseViewModel {
    @Published var isFetchingProviders: Bool = true
    @Published var nominatedProviders: [NominatedProvider]? = []
    var navigateToRequestDetailsSubject = PassthroughSubject<Void,Never>()

    var timer: AnyCancellable?
    var requestID: Int
    
    init(requestID: Int) {
        self.requestID = requestID
    }

    public func startFetchingNominatedProviders(){
        isFetchingProviders = true
        
        Task {
            await fetchNominatedProviders()
        }
        
        timer = Timer.publish(every: 5, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        Task {
                            await self.fetchNominatedProviders()
                        }
                    }
    }
    
    func stopFetchingProviders() {
        timer?.cancel()
    }

    @MainActor
    func fetchNominatedProviders() async {
        state.startLoading()
        do {
            let route = APIRouter.RequestNominatedProviders(requestID)
            let response : NominatedProviderResponse?
            response = try await APIService.shared.fetch(route: route)
            
            if let nominatedProviders = response?.nominatedProviders, !nominatedProviders.isEmpty {
                self.nominatedProviders = nominatedProviders
                isFetchingProviders = false
                stopFetchingProviders()
            }
            
            self.state.endLoading()
            error = nil
        } catch {
            self.error = error
        }
        state.endLoading()
    }
    
    @MainActor
    func addTempProviderToRequest(providerId:Int) async {
        state.startLoading()
        do {
            let request = AddTempProviderToRequest(tempProviderID: providerId, requestID: requestID, providerReactionToRequest: nil)
            let route = APIRouter.AddTempProviderToRequest(request)
            let response : String?
            response = try await APIService.shared.fetch(route: route)
            navigateToRequestDetailsSubject.send(())
            
            self.state.endLoading()
            error = nil
        } catch {
            self.error = error
            navigateToRequestDetailsSubject.send(())
        }
        state.endLoading()
    }
}
