//
//  AuthRequestTest.swift
//  MyGeekBrainStoreTests
//
//  Created by Dmitry Zasenko on 27.04.22.
//

import XCTest
@testable import MyGeekBrainStore

class AuthRequestTest: XCTestCase {
    struct AuthExpressionStub {
        let result: Int
    }
    
    let authRequest = RequestFactory().makeAuthRequestFatory()
    let userName = "Dmitry"
    let password = "12345"
    let email = "email@email.com"
    let gender: User.Gender = .male
    let creditCard = "3453-4534-5345"
    let bio = "bla bla"
    let expressionLogInStub: LoginResult = LoginResult(result: 1, user: User(id: 123, login: "geekbrains", name: "John", lastname: "Doe"))
    let expressionStub: AuthExpressionStub = AuthExpressionStub(result: 1)
    
    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}
    
    func testLogIn() throws {
        let expectation = XCTestExpectation(description: "logIn")
        authRequest.login(userName: userName, password: password) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionLogInStub.result)
                XCTAssertEqual(result.user.id, self.expressionLogInStub.user.id)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRegistration() throws {
        let expectation = XCTestExpectation(description: "Registration")
        authRequest.register(username: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionStub.result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLogOut() throws {
        let expectation = XCTestExpectation(description: "LogOut")
        authRequest.logout(completionHandler: { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionStub.result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testChangeUserData() throws {
        let expectation = XCTestExpectation(description: "ChangeUserData")
        authRequest.changeUserData(username: userName, password: password, email: email, gender: gender, creditCard: creditCard, bio: bio) { response in
            switch response.result {
            case .success(let result):
                XCTAssertEqual(result.result, self.expressionStub.result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
