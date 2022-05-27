//
//  User.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 25.04.22.
//

import Foundation

struct UserResult: Codable {
    
    let id: Int
    let login: String
    let name: String
    let lastname: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id_user"
        case login = "user_login"
        case name = "user_name"
        case lastname = "user_lastname"
    }
    
    enum Gender: String {
        case male = "m"
        case female = "f"
    }
    
}
