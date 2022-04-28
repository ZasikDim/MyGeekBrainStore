//
//  ProductRequest.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 28.04.22.
//

import Foundation
import Alamofire

class ProductRequest: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
    
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ProductRequest: ProductRequestFactory {
    func getProducts(id: Int, page: Int, completionHandler: @escaping (AFDataResponse<[ProductResult]>) -> Void) {
        let requestModel = Product(baseUrl: baseUrl, id: id, page: page)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    func getProduckById(id: Int, completionHandler: @escaping (AFDataResponse<ProductByIdResult>) -> Void) {
        let requestModel = ProductById(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProductRequest {
    struct Product: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"
        let id: Int
        let page: Int
        var parameters: Parameters? {
            return [
                "id_category": id,
                "page_numbe" : page
            ]
        }
    }
    struct ProductById: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "getGoodById.json"
        let id: Int
        var parameters: Parameters? {
            return [
                "id_product": id
            ]
        }
    }
}
