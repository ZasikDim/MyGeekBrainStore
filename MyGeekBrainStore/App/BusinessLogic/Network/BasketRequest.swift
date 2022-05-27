//
//  BasketRequest.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 23.05.22.
//

import Foundation
import Alamofire

class BasketRequest: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    
    let baseUrl = URL(string: "https://glacial-wildwood-24509.herokuapp.com/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension BasketRequest: BasketRequestFactory {
    func getBasket(userId: Int, completionHandler: @escaping (AFDataResponse<GetBasketResult>) -> Void) {
        let requestModel = GetBasketRequestModel(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteAllBasket(userId: Int, completionHandler: @escaping (AFDataResponse<DeleteAllBasketResult>) -> Void) {
        let requestModel = DeleteAllBasketRequestModel(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func pay(userId: Int, completionHandler: @escaping (AFDataResponse<PayResult>) -> Void) {
        let requestModel = PayBasketRequestModel(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addToBasket(productId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void) {
        let requestModel = AddToBasketRequestModel(baseUrl: baseUrl, productId: productId, quantity: quantity)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    func deleteFromBasket(productId: Int, completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        let requestModel = DeleteFromBasketRequestModel(baseUrl: baseUrl, productId: productId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension BasketRequest {
    struct AddToBasketRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addToBasket"
        let productId: Int
        let quantity: Int
        var parameters: Parameters? {
            return [
                "id_product": productId,
                "quantity" : quantity
            ]
        }
    }
    struct DeleteFromBasketRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteFromBasket"
        let productId: Int
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
    struct DeleteAllBasketRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "deleteAllFromBasket"
        let userId: Int
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
    struct PayBasketRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"
        let userId: Int
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
    struct GetBasketRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "getBasket"
        let userId: Int
        var parameters: Parameters? {
            return [
                "id_user": userId
            ]
        }
    }
}
