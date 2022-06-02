//
//  LoginResult.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 25.04.22.
//

import Foundation

struct LoginResult: Codable {
    let result: Int
    let user: UserResult
}
