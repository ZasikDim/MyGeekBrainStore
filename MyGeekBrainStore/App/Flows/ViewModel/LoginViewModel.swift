//
//  LoginViewModel.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 27.05.22.
//

import Foundation

final class LoginViewModel {

    private let reportExceptions = CrashlyticsReport()
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
                } else {
                    self.reportExceptions.report(error: "logIn result 0", code: CrashlyticsCode.rejectionResult.rawValue)
                }
            case .failure(let error):
                self.reportExceptions.report(error: error.localizedDescription, code: CrashlyticsCode.failureResponse.rawValue)
                completion(false)
            }
        }
    }
}
