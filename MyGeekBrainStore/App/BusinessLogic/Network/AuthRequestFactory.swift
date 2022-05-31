//
//  AuthRequestFactory.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 25.04.22.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    func logout(completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
    func register(username: String, password: String, email: String, gender: Gender, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegisterationResult>) -> Void)
    func changeUserData(username: String, password: String, email: String, gender: Gender, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}
