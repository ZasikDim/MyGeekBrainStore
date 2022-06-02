//
//  ReviewRequestFactory.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 19.05.22.
//

import Foundation
import Alamofire

protocol ReviewRequestFactory {
    func addReview(userId: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
    func approveReview(commentId: Int, completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void)
    func removeReview(commentId: Int, completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
}
