//
//  ReviewRequestTest.swift
//  MyGeekBrainStoreTests
//
//  Created by Dmitry Zasenko on 19.05.22.
//

import XCTest
@testable import MyGeekBrainStore

class ReviewRequestTest: XCTestCase {
    let request = RequestFactory().makeReviewRequestFactory()
    let expressionAddReviewStub = AddReviewResult(result: 1, userMessage: "Ваш отзыв был передан на модерацию", errorMessage: nil)
    let expressionApproveReviewStub = ApproveReviewResult(result: 1, errorMessage: nil)
    let expressionRemoveReviewStub = RemoveReviewResult(result: 1, errorMessage: nil)
    
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testAddReview() throws {
        let expectation = XCTestExpectation(description: "AddReview")
        request.addReview(userId: 1, text: "good day") { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionAddReviewStub.result)
                XCTAssertEqual(result.userMessage, self.expressionAddReviewStub.userMessage)
                XCTAssertEqual(result.errorMessage, self.expressionAddReviewStub.errorMessage)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testApproveReview() throws {
        let expectation = XCTestExpectation(description: "ApproveReview")
        request.approveReview(commentId: 123) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionApproveReviewStub.result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRemoveReview() throws {
        let expectation = XCTestExpectation(description: "RemoveReview")
        request.removeReview(commentId: 123) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionRemoveReviewStub.result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
