//
//  CatalogItemViewModel.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 27.05.22.
//

import Foundation

final class CatalogItemViewModel {
    
    var item: ProductResult? = nil
    var quantity = 1
    var updateView: (() -> Void)?
    private let basketRequestFactory = RequestFactory().makeBasketRequestFactory()
    private let basket = Basket.shared

    func addToBasket() {
            if let item = item {
                basketRequestFactory.addToBasket(productId: item.id, quantity: quantity) { [weak self] response in
                    guard let self = self else { return }
                    switch response.result {
                    case .success(let result):
                        if result.result == 1 {
                            self.basket.items.append(BasketContentResult(id: item.id, name: item.name, price: item.price, quantity: self.quantity))
                            self.updateView?()
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
}
