//
//  BasketViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 24.05.22.
//

import UIKit

//protocol BasketViewDelegate: AnyObject {
//    func updateView()
//}

final class BasketViewController: UIViewController {
    
    @IBOutlet weak var basketTableView: UITableView! {
        didSet {
            basketTableView.dataSource = self
            basketTableView.delegate = self
            
        }
    }
    private let viewModel = BasketViewModel()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        basketTableView.reloadData()
    }
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        viewModel.pay()
    }
    @IBAction func deleteAllButtonTapped(_ sender: UIButton) {
        viewModel.deleteAllBasket()
    }
    
    private func configureViewModel() {
        viewModel.updateView = { [unowned self] in
            DispatchQueue.main.sync {
                self.basketTableView.reloadData()
            }
        }
        viewModel.updateViewWithMassage = { [unowned self] in
            guard let massage = viewModel.massage else { return }
            let alert = UIAlertController(title: nil, message: massage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
                self.basketTableView.reloadData()
            }
        }
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basket.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let resultItem = viewModel.basket.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier) as! BasketTableViewCell
        cell.configure(result: resultItem)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let id = viewModel.basket.items[indexPath.row].id
            viewModel.deleteFromBasket(productId: id)
            viewModel.basket.items.remove(at: indexPath.row)
            basketTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
