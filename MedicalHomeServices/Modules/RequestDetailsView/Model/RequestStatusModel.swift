//
// RequestStatusModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation


struct RequestStatusResponse : Codable {
    let requestID:Int?
    let status:String?
    let tempProviderId:String?
    let tempProviderName:String?
}
