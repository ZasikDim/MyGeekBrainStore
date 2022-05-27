//
//  Basket.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 26.05.22.
//

import Foundation

final class Basket {
    static let shared = Basket()
    private init() {}
    var items: [BasketContentResult] = []
}
