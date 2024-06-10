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
    let name:String?
    let id:Int?
}
