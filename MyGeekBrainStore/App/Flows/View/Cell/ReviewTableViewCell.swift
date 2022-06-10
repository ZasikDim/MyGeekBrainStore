//
//  ReviewTableViewCell.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 07.06.22.
//

import UIKit

protocol ReviewTableViewCellDelegate: AnyObject {
    func approveReview(commentId: Int)
    func deleteReview(commentId: Int)
}

class ReviewTableViewCell: UITableViewCell {
    
    static let identifier = "ReviewTableViewCell"
    
    @IBOutlet weak var itemIdLable: UILabel!
    @IBOutlet weak var reviewIdLable: UILabel!
    @IBOutlet weak var reviewLable: UILabel!

    weak var cellDelegate: ReviewTableViewCellDelegate?
    private var review: ReviewModel = ReviewModel(itemId: 0, text: "")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func approveButtonTapped(_ sender: UIButton) {
        cellDelegate?.approveReview(commentId: review.id)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        cellDelegate?.deleteReview(commentId: review.id)
    }
    
    func configure(review: ReviewModel) {
        self.review = review
        itemIdLable.text = "id товара: " + String(review.itemId)
        reviewIdLable.text = "id отзыва: " + String(review.id)
        reviewLable.text = review.text
    }
}
