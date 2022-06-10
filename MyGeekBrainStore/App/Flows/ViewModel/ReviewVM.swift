//
//  ReviewVM.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 07.06.22.
//

import Foundation

final class ReviewVM {

    private let reviewRequest = RequestFactory().makeReviewRequestFactory()
    var itemId: Int = 0
    var reviews = Review.shared
    var updateViewWithMassage: (() -> Void)?
    var massage: String?
    
    func addReview(userId: Int, review: String) {
        reviewRequest.addReview(userId: userId, text: review) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.massage = result.userMessage
                    self.reviews.items.append(ReviewModel(itemId: self.itemId, text: review))
                    self.updateViewWithMassage?()
                    
                    self.massage = nil
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func approveReview(commentId: Int) {
        reviewRequest.approveReview(commentId: commentId) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.massage = "Отзыв одобрен"
                    self.reviews.items = self.reviews.items.filter() { $0.id != commentId}
                    self.updateViewWithMassage?()
                    self.massage = nil
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func removeReview(commentId: Int) {
        reviewRequest.removeReview(commentId: commentId) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                if result.result == 1 {
                    self.massage = "Отзыв удален"
                    self.reviews.items = self.reviews.items.filter() { $0.id != commentId}
                    self.updateViewWithMassage?()
                    self.massage = nil
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
