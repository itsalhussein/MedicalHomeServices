//
// UserRepsonse.swift
// MedicalHomeServices
//
// Created by Hussein Anwar.
//


import Foundation

struct UserRepsonse : Codable {
    let isAuthenticated : Bool?
    let username : String?
    let email : String?
    let roles: [String]?
    let token : String?
    let userID : Int?
    
    enum CodingKeys: String, CodingKey {
        case isAuthenticated, username, email, token,roles,userID
    }
    
    init(isAuthenticated: Bool?,
         username: String?,
         email: String?,
         roles: [String]?,
         token: String?,
         userID: Int) {
           self.isAuthenticated = isAuthenticated
           self.username = username
           self.email = email
           self.roles = roles
           self.token = token
           self.userID = userID
       }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        isAuthenticated = try container.decodeIfPresent(Bool.self, forKey: .isAuthenticated)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        email = try container.decodeIfPresent(String.self, forKey: .email)
        roles = try container.decodeIfPresent([String].self, forKey: .roles)
        token = try container.decodeIfPresent(String.self, forKey: .token)
        userID =  try container.decodeIfPresent(Int.self, forKey: .userID)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(isAuthenticated, forKey: .isAuthenticated)
        try container.encodeIfPresent(username, forKey: .username)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(token, forKey: .token)
        try container.encodeIfPresent(roles, forKey: .roles)
        try container.encodeIfPresent(userID, forKey: .userID)
    }
}



extension UserRepsonse: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? newJSONDecoder().decode(UserRepsonse.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

