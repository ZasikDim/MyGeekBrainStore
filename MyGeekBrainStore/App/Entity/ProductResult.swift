//
//  ProductResult.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 28.04.22.
//

import Foundation

struct CatalogResult: Codable {
    let page: Int
    let products: [ProductResult]
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case page = "page_number"
        case products
        case error = "error_message"
    }
}

struct ProductResult: Codable {
    let id: Int
    let name: String
    let price: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price
    }
}
