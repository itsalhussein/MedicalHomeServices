//
// UserServiceModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation

struct UserServiceModel : Codable {
    let providerID : Int?
    let serviceID : Int?
    let serviceName : String?
    let approved : Bool?
}
