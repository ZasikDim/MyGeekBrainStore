//
//  Review.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 07.06.22.
//

import Foundation

final class Review {
    static let shared = Review()
    private init() {}
    var items: [ReviewModel] = []
}
