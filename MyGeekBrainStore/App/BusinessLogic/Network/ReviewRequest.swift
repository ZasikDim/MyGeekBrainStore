//
//  ReviewRequest.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 19.05.22.
//

import Foundation
import Alamofire

class ReviewRequest: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    
    let baseUrl = URL(string: "https://glacial-wildwood-24509.herokuapp.com/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension ReviewRequest: ReviewRequestFactory {
    func addReview(userId: Int, text: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReviewRequestModel(baseUrl: baseUrl, userId: userId, text: text)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func approveReview(commentId: Int, completionHandler: @escaping (AFDataResponse<ApproveReviewResult>) -> Void) {
        let requestModel = ApproveReviewRequestModel(baseUrl: baseUrl, commentId: commentId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func removeReview(commentId: Int, completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void) {
        let requestModel = ApproveReviewRequestModel(baseUrl: baseUrl, commentId: commentId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ReviewRequest {
    struct AddReviewRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        let userId: Int
        let text: String
        var parameters: Parameters? {
            return [
                "id_user": userId,
                "text" : text
            ]
        }
    }
    struct ApproveReviewRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "approveReview"
        let commentId: Int
        var parameters: Parameters? {
            return [
                "id_comment": commentId
            ]
        }
    }
    struct RemoveReviewRequestModel: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "removeReview"
        let commentId: Int
        var parameters: Parameters? {
            return [
                "id_comment": commentId
            ]
        }
    }
}
