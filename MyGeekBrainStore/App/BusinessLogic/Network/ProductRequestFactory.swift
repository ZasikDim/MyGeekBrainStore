//
//  ProductRequestFactory.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 28.04.22.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func getProducts(id: Int, page: Int, completionHandler: @escaping (AFDataResponse<CatalogResult>) -> Void)
    func getProduckById(id: Int, completionHandler: @escaping (AFDataResponse<ProductByIdResult>) -> Void)
}
