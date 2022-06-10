//
//  CatalogItemViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 26.05.22.
//

import UIKit

class CatalogItemViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var stepper: UIStepper!

    let viewModel = CatalogItemViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func addToBasket(_ sender: UIButton) {
        viewModel.addToBasket()
    }
    @IBAction func stepperClicked(_ sender: UIStepper) {
        count.text = "\(Int(sender.value))"
        viewModel.quantity = Int(sender.value)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "fromItemToReviewView" else { return }
        guard let destination = segue.destination as? ReviewViewController, let itemId = viewModel.item?.id else { return }
        destination.viewModel.itemId = itemId
    }
    
    private func configure() {
        stepper.maximumValue = 10.0
        stepper.minimumValue = 1.0
        name.text = viewModel.item?.name ?? ""
        let a = viewModel.item?.price ?? 0
        price.text = "\(a) руб."
        
        viewModel.updateView = { [unowned self] in
            
            let alert = UIAlertController(title: nil, message: "Товар добавлен в корзину.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.performSegue(withIdentifier: "unwindFromCatalogItemView", sender: self)
                
            }))
            DispatchQueue.main.sync {
                self.tabBarController?.tabBar.items?[1]
                    .badgeValue = String(Basket.shared.items.count)
                self.present(alert, animated: true)
                
            }
        }
    }
}
