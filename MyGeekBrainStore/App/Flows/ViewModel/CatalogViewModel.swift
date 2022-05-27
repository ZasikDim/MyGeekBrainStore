//
//  CatalogViewModel.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 27.05.22.
//

import Foundation

final class CatalogViewModel {
    
    let catalog = Catalog.shared
    private let user = User.shared
    private let catalogRequestFactory = RequestFactory().makeProductRequestFactory()
    
    var updateView: (() -> Void)?
    
    init() {
        getCatalog()
    }
    
    func getCatalog() {
        catalogRequestFactory.getProducts(id: 1, page: 1) { [weak self] response in
            guard let self = self else { return }
            switch response.result {
            case .success(let result):
                self.catalog.items = result.products
                self.updateView?()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
