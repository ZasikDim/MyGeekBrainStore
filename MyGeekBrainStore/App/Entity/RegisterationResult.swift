//
//  RegisterationResult.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 26.04.22.
//

import Foundation

struct RegisterationResult: Codable {
    let result: Int
    let userMessage: String?
    var errorMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case userMessage = "user_message"
        case errorMessage = "error_message"
    }
}
