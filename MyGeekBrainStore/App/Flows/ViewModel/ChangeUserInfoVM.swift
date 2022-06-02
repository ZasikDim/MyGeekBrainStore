//
//  ChangeUserInfoVM.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 31.05.22.
//

import Foundation

final class ChangeUserInfoVM {

    private let authRequest = RequestFactory().makeAuthRequestFatory()
    
    var updateViewWithMassage: (() -> Void)?
    var massage: String?

    func changeUserInfo(username: String, password: String, email: String, gender: Gender, creditCard: String, bio: String) {
        authRequest.changeUserData(username: username, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    User.shared.name = username
                    User.shared.password = password
                    User.shared.email = email
                    User.shared.creditCard = creditCard
                    User.shared.bio = bio
                    User.shared.gender = gender
                    print("--------------------")
                    print(result)
                    self.massage = "Ваши данные изменились"
                    self.updateViewWithMassage?()
                    self.massage = nil
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
