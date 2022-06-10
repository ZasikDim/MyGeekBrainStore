//
//  ReviewViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 07.06.22.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var reviewTableView: UITableView! {
        didSet {
            reviewTableView.dataSource = self
            reviewTableView.delegate = self
            
        }
    }
    let viewModel = ReviewVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        checkFields()
    }
    
    private func configure() {
        viewModel.updateViewWithMassage = { [unowned self] in
            guard let massage = viewModel.massage else { return }
            showAlert(massage: massage)
        }
    }
    
    private func checkFields() {
        if let review = reviewTextField.text, !review.isEmpty {
            viewModel.addReview(userId: User.shared.id, review: review)
        }
        else {
            showAlert(massage: "Введите текст")
        }
    }
    
    private func showAlert(massage: String) {
        let alert = UIAlertController(title: nil, message: massage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.reviewTextField.text = ""
                self.reviewTableView.reloadData()
            }))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviews.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let review = viewModel.reviews.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier) as! ReviewTableViewCell
        cell.cellDelegate = self
        cell.configure(review: review)
        return cell
    }
}

extension ReviewViewController: ReviewTableViewCellDelegate {
    func approveReview(commentId: Int) {
        viewModel.approveReview(commentId: commentId)
    }
    
    func deleteReview(commentId: Int) {
        viewModel.removeReview(commentId: commentId)
    }
}
