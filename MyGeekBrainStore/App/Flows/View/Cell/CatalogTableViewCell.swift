//
//  CatalogTableViewCell.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 24.05.22.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    static let identifier = "CatalogCell"
 
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(result: ProductResult) {
        name.text = result.name
        price.text = "цена: \(result.price)"
    }
}
