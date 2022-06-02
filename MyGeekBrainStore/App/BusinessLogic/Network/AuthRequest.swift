//
//  Auth.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 25.04.22.
//

import Foundation
import Alamofire

class AuthRequest: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://glacial-wildwood-24509.herokuapp.com/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension AuthRequest: AuthRequestFactory {
    
    func register(username: String, password: String, email: String, gender: Gender, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegisterationResult>) -> Void) {
        let requestModel = Registeration(baseUrl: baseUrl, login: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(username: String, password: String, email: String, gender: Gender, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, login: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension AuthRequest {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "login"
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
    
    struct Registeration: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "register"
        let id: Int = 123
        let login: String
        let password: String
        let email: String
        let gender: Gender
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": id,
                "username": login,
                "password": password,
                "email": email,
                "gender": gender.rawValue,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
    
    struct Logout: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "logout"
        let id: Int = 123
        var parameters: Parameters? {
            return [
                "id_user": id
            ]
        }
    }
    
    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "changeUserData"
        let id: Int = 123
        let login: String
        let password: String
        let email: String
        let gender: Gender
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": id,
                "username": login,
                "password": password,
                "email": email,
                "gender": gender.rawValue,
                "credit_card": creditCard,
                "bio": bio
            ]
        }
    }
}
