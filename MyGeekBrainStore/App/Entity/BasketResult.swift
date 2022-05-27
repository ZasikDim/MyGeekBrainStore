//
//  BasketResult.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 23.05.22.
//

import Foundation

struct AddToBasketResult: Codable {
    let result: Int
    let errorMessage: String?
}

struct DeleteFromBasketResult: Codable {
    let result: Int
    let errorMessage: String?
}

struct DeleteAllBasketResult: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}

struct GetBasketResult: Codable {
    let amount: Int
    let contents: [BasketContentResult]
    let countGoods: Int
}

struct BasketContentResult: Codable {
    let id: Int
    let name: String
    let price: Double
    let quantity: Int

    enum CodingKeys: String, CodingKey {
        case id = "id_product"
        case name = "product_name"
        case price
        case quantity
    }
}

struct PayResult: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}
