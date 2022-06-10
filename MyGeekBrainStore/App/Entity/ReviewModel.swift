//
//  ReviewModel.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 07.06.22.
//

import Foundation

struct ReviewModel {
    let id = Int.random(in: 0 ..< 100)
    let itemId: Int
    let text: String
}
