//
//  LoginViewModel.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 27.05.22.
//

import Foundation

final class LoginViewModel {

    private let authRequestFactory = RequestFactory().makeAuthRequestFatory()
    private var user = User.shared
    
    func logIn(login: String, password: String, completion: @escaping (Bool) -> Void) {
        authRequestFactory.login(userName: login, password: password) {  [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.user.id = result.user.id
                    self.user.login = result.user.login
                    self.user.name = result.user.name
                    self.user.lastname = result.user.lastname
                    completion(true)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
                
            }
        }
    }
}
