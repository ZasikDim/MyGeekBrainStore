//
//  RegistrationViewModel.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 31.05.22.
//

import Foundation

final class RegistrationViewModel {
    
    private let authRequest = RequestFactory().makeAuthRequestFatory()
    private let reportExceptions = CrashlyticsReport()
    
    var updateViewWithMassage: (() -> Void)?
    var massage: String?
    
    func registration(username: String, password: String, email: String, gender: Gender, creditCard: String, bio: String) {
        authRequest.register(username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.massage = result.userMessage ?? ""
                    self.updateViewWithMassage?()
                    self.massage = nil
                    
                } else {
                    self.reportExceptions.report(error: "registration result 0", code: CrashlyticsCode.rejectionResult.rawValue)
                }
            case .failure(let error):
                self.reportExceptions.report(error: error.localizedDescription, code: CrashlyticsCode.failureResponse.rawValue)
                print(error.localizedDescription)
            }
        }
    }
}
