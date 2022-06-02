//
//  BasketRequestFactory.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 23.05.22.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
    func addToBasket(productId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void)
    func deleteFromBasket(productId: Int, completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void)
    func deleteAllBasket(userId: Int, completionHandler: @escaping (AFDataResponse<DeleteAllBasketResult>) -> Void)
    func pay(userId: Int, completionHandler: @escaping (AFDataResponse<PayResult>) -> Void)
    func getBasket(userId: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void)
}
