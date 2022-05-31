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
    var id: Int = 0
    var login: String = ""
    var password: String = ""
    var name: String = ""
    var lastname: String = ""
    var email: String = ""
    var gender: Gender = .male
    var creditCard: String = ""
    var bio: String = ""
}
