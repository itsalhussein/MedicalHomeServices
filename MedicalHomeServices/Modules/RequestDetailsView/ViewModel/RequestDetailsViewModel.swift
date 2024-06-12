//
// RequestDetailsViewModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import Combine

class RequestDetailsViewModel : BaseViewModel {
    @Published var isFetchingRequestStatus: Bool = true
    @Published var requestStatusResponse: RequestStatusResponse?
    var requestId:Int
    var timer: AnyCancellable?
    var dismissWhenDoneSubject = PassthroughSubject<Void,Never>()
    var dismissAndNavigateToProvidersList = PassthroughSubject<Void,Never>()

    init(requestId:Int){
        self.requestId = requestId
    }
    
    public func startFetchingRequestStatus(){
        isFetchingRequestStatus = true
        
        Task {
            await fetchReqestStatus()
        }
        
        timer = Timer.publish(every: 5, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        Task {
                            await self.fetchReqestStatus()
                        }
                    }
                    
    }
    
    func stopFetchingProviders() {
        timer?.cancel()
        timer = nil 
    }

    
    @MainActor
    func fetchReqestStatus() async {
        state.startLoading()
        do {
            let route = APIRouter.GetRequestStatus(requestId)
            let response : RequestStatusResponse?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                isFetchingRequestStatus = false 
                requestStatusResponse = response
                print("requestStatusResponse ===== ",requestStatusResponse)
                if response.status == "Done" {
                    dismissWhenDoneSubject.send(())
                }
                
                if response.tempProviderID == nil {
                    dismissAndNavigateToProvidersList.send(())
                }
            }
            self.state.endLoading()
            error = nil
        } catch {
            self.error = error
        }
        state.endLoading()
    }
}
