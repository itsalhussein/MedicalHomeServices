//
// ServiceRequestModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation

struct ServiceRequestModel : Codable {
    let requestID : Int?
    let longitude: Double?
    let latitude : Double?
    let serviceID : Int?
    let appUserID : Int?
}
