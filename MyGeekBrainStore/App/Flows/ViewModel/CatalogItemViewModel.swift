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
    private let basketRequestFactory = RequestFactory().makeBasketRequestFactory()
    private let basket = Basket.shared
    
    var updateViewWithMassage: (() -> Void)?
    var massage: String?
    
    init() {
    }
    
    func addToBasket() {
            if let item = item {
                basket.items.append(BasketContentResult(id: item.id, name: item.name, price: item.price, quantity: quantity))
                
                basketRequestFactory.addToBasket(productId: item.id, quantity: quantity) { [weak self] response in
                    guard let self = self else { return }
                    switch response.result {
                    case .success(let result):
                        if result.result == 1 {
                            self.massage = "Товар добавлен в корзину."
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            }
        }
}
