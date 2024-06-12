//
// Helper.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
import NotificationBannerSwift

final class Helper {
    
    public static func showBanner(title: String,subtitle:String? = nil,style:BannerStyle = .success) {
        let banner = NotificationBanner(title: title, subtitle: subtitle, style: style)
        banner.show()
    }
    
    @MainActor
    public static func updateRequestStatus(requestStatus:UpdateRequestStatus,completion: @escaping (RequestStatusResponse)->Void) async {
        do {
            let route = APIRouter.UpdateRequestStatus(requestStatus)
            let response : RequestStatusResponse?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                completion(response)
            }
        } catch {
            completion(RequestStatusResponse(requestID: requestStatus.requestID, status: "requestStatus", tempProviderID: 0, tempProviderName: "requestStatus.tempProviderID"))
        }
    }
    
    @MainActor
    public static func actionByProviderToRequest(requestStatus:ActionByProviderToRequest,completion: @escaping (RequestStatusResponse)->Void) async {
        do {
            let route = APIRouter.ActionByProviderToRequest(requestStatus)
            let response : String?
            response = try await APIService.shared.fetch(route: route)
            if let response {
                completion(RequestStatusResponse(requestID: requestStatus.requestID, status: "requestStatus", tempProviderID: requestStatus.tempProviderID, tempProviderName: "requestStatus.tempProviderID"))
            }
        } catch {
            completion(RequestStatusResponse(requestID: requestStatus.requestID, status: "requestStatus", tempProviderID: requestStatus.tempProviderID, tempProviderName: "requestStatus.tempProviderID"))
        }
    }
}
