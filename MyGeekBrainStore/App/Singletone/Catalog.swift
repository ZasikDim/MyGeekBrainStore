//
//  Catalog.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 27.05.22.
//

import Foundation

final class Catalog {
    static let shared = Catalog()
    private init() {}
    var items: [ProductResult] = []
}
