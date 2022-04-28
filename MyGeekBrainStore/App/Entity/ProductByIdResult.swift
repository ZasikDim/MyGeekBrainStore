//
//  ProductById.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 28.04.22.
//

import Foundation

struct ProductByIdResult: Codable {
    let result: Int
    let name: String
    let price: Double
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case result
        case name = "product_name"
        case price = "product_price"
        case description = "product_description"
    }
}
