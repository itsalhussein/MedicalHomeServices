//
// SignUpModel.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation
struct SignUpRequest : Codable {
    let mobileNumber,password,fullName,email,dateOfBirth:String?
}

typealias SignInRequest = SignUpRequest
