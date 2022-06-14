//
//  BasketViewControllerVM.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 26.05.22.
//

import Foundation

final class BasketViewModel {
    var basket: Basket = Basket.shared
    var updateView: (() -> Void)?
    var updateViewWithMassage: (() -> Void)?
    var massage: String?
    
    private let user = User.shared
    private let basketRequestFactory = RequestFactory().makeBasketRequestFactory()
    private let reportExceptions = CrashlyticsReport()
    
    func pay() {
        if !basket.items.isEmpty {
            basketRequestFactory.pay(userId: user.id) { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case .success(let result):
                    if result.result == 1 {
                        self.updateMassage(massage: result.userMessage ?? "")
                    } else {
                        self.reportExceptions.report(error: "pay result 0", code: CrashlyticsCode.rejectionResult.rawValue)
                    }
                case .failure(let error):
                    self.reportExceptions.report(error: error.localizedDescription, code: CrashlyticsCode.failureResponse.rawValue)
                    print(error.localizedDescription)
                }
            }
        }
    }
    func deleteAllBasket() {
        basketRequestFactory.deleteAllBasket(userId: user.id) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.updateMassage(massage: result.userMessage ?? "")
                }
            case .failure(let error):
                self.reportExceptions.report(error: error.localizedDescription, code: CrashlyticsCode.failureResponse.rawValue)
                print(error.localizedDescription)
            }
        }
    }
    func deleteFromBasket(productId: Int) {
        basketRequestFactory.deleteFromBasket(productId: productId) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.massage = "Продукт удален"
                    self.updateViewWithMassage?()
                    self.massage = nil
                }
            case .failure(let error):
                self.reportExceptions.report(error: error.localizedDescription, code: CrashlyticsCode.failureResponse.rawValue)
                print(error.localizedDescription)
            }
        }
    }
    private func updateMassage(massage: String) {
        self.massage = massage
        self.basket.items = []
        self.updateViewWithMassage?()
        self.massage = nil
    }
}
