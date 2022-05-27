//
//  ProductRequestTest.swift
//  MyGeekBrainStoreTests
//
//  Created by Dmitry Zasenko on 28.04.22.
//

import XCTest
@testable import MyGeekBrainStore

class ProductRequestTest: XCTestCase {
    let productRequest = RequestFactory().makeProductRequestFactory()
    let expressionProductStub: [ProductResult] = [
        ProductResult(id: 123, name: "Ноутбук", price: 45600),
        ProductResult(id: 456, name: "Мышка", price: 1000)
    ]
    let expressionProductByIdStub = ProductByIdResult(result: 1, name: "Ноутбук", price: 45600, description: "Мощный игровой ноутбук")

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testProduct() throws {
        let expectation = XCTestExpectation(description: "Product")
        productRequest.getProducts(id: 1, page: 1) { response in
            switch response.result {
            case .success(let result):
                for i in 0 ..< result.products.count {
                    XCTAssertEqual(result.products[i].id, self.expressionProductStub[i].id)
                    XCTAssertEqual(result.products[i].name, self.expressionProductStub[i].name)
                    XCTAssertEqual(result.products[i].price, self.expressionProductStub[i].price)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testProductById() throws {
        let expectation = XCTestExpectation(description: "ProductById")
        productRequest.getProduckById(id: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionProductByIdStub.result)
                XCTAssertEqual(result.name, self.expressionProductByIdStub.name)
                XCTAssertEqual(result.price, self.expressionProductByIdStub.price)
                XCTAssertEqual(result.description, self.expressionProductByIdStub.description)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
