//
//  MyBasket.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 24.05.22.
//

import Foundation

final class User {
    static let shared = User()
    private init() {}
    let id: Int = 123
    var login: String = "123"
    var name: String = "123fv"
    var lastname: String = "123"
}
