//
//  ReviewResult.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 19.05.22.
//

import Foundation

struct AddReviewResult: Codable {
    let result: Int
    let userMessage: String?
    let errorMessage: String?
}

struct ApproveReviewResult: Codable {
    let result: Int
    let errorMessage: String?
}

struct RemoveReviewResult: Codable {
    let result: Int
    let errorMessage: String?
}
