//
//  BasketTableViewCell.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 24.05.22.
//

import UIKit


class BasketTableViewCell: UITableViewCell {
    
    static let identifier = "BasketTableViewCell"
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configure(result: BasketContentResult) {
        name.text = result.name
        price.text = "цена: \(result.price)"
        quantity.text = "количество: \(result.quantity)"
    }
}
