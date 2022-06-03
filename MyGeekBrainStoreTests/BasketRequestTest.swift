//
//  BasketRequestTest.swift
//  MyGeekBrainStoreTests
//
//  Created by Dmitry Zasenko on 03.06.22.
//

import XCTest
@testable import MyGeekBrainStore

class BasketRequestTest: XCTestCase {
    let request = RequestFactory().makeBasketRequestFactory()
    let expressionPayStub = PayResult(result: 1, userMessage: "Оплата успешно прошла", errorMessage: nil)
    let expressionDeleteAllBasketStub = DeleteAllBasketResult(result: 1, userMessage: "Все товары из корзины удалены", errorMessage: nil)
    let expressionDeleteFromBasketStub = DeleteFromBasketResult(result: 1, errorMessage: nil)
    let expressionAddToBasketStub = AddToBasketResult(result: 1, errorMessage: expressionAddToBasketStub)
    
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testPay() throws {
        let expectation = XCTestExpectation(description: "Pay")
        request.pay(userId: 1) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionPayStub.result)
                XCTAssertEqual(result.userMessage, self.expressionPayStub.userMessage)
                XCTAssertEqual(result.errorMessage, self.expressionPayStub.errorMessage)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testDeleteAllBasket() throws {
        let expectation = XCTestExpectation(description: "DeleteAllBasket")
        request.deleteAllBasket(userId: 1) { response in
            switch response.result{
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionDeleteAllBasketStub.result)
                XCTAssertEqual(result.userMessage, self.expressionDeleteAllBasketStub.userMessage)
                XCTAssertEqual(result.errorMessage, self.expressionDeleteAllBasketStub.errorMessage)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testDeleteFromBasket() throws {
        let expectation = XCTestExpectation(description: "DeleteFromBasket")
        request.deleteFromBasket(productId: 1) { response in
        switch response.result{
        case .success(let result):
            XCTAssertEqual(result.result, self.expressionDeleteFromBasketStub.result)
            XCTAssertEqual(result.errorMessage, self.expressionDeleteFromBasketStub.errorMessage)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAddToBasket() throws {
        let expectation = XCTestExpectation(description: "DeleteFromBasket")
        request.addToBasket(productId: 1, quantity: 1) { response in
        switch response.result{
        case .success(let result):
            XCTAssertEqual(result.result, self.expressionAddToBasketStub.result)
        case .failure(let error):
            XCTFail(error.localizedDescription)
        }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
