//
// NominatedProvider.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation

struct NominatedProviderResponse : Codable {
    let requestID : Int?
    let nominatedProviders : [NominatedProvider]?
}

struct NominatedProvider : Codable,Identifiable {
    var id = UUID()
    let fullName:String?
    let providerID:Int?
    let userName:String?
    let distance: Double?
    enum CodingKeys: CodingKey {
        case fullName
        case providerID
        case userName
        case distance
    }
}


struct AddTempProviderToRequest : Codable {
    let tempProviderID : Int?
    let requestID : Int?
    let providerReactionToRequest : Int?
}

typealias ActionByProviderToRequest = AddTempProviderToRequest
 
struct UpdateRequestStatus : Codable {
    let requestID: Int?
    let userID: Int?
    let status: Int?
}


struct ResultResponse : Codable {
    let message:String?
    let success:Bool?
}




struct NominatedRequestResponse : Codable {
    let requestID : Int?
    let nominatedRequests : [NominatedRequestModel]?
}

struct NominatedRequestModel : Codable,Identifiable {
    var id = UUID()
    let requestID : Int?
    let distance : Double?
    let serviceId:Int?
    let appUserId:Int?
    let userFullName:String?
    let userName:String?
    enum CodingKeys: CodingKey {
        case requestID
        case distance
        case serviceId
        case appUserId
        case userFullName
        case userName
    }
}


