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
    let tempProviderID:Int?
    let tempProviderName:String?
}

