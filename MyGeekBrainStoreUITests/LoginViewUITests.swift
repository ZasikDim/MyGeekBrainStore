//
//  LoginViewUITests.swift
//  MyGeekBrainStoreUITests
//
//  Created by Dmitry Zasenko on 08.06.22.
//

import XCTest

class LoginViewUITests: XCTestCase {
    
    let app = XCUIApplication()
    var loginViewController:  XCUIElement!
    var loginTextField: XCUIElement!
    var passwordTextField: XCUIElement!
    var loginButton: XCUIElement!
    var registrationButton: XCUIElement!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        loginViewController = app.otherElements["LoginViewController"].firstMatch
        loginTextField = loginViewController.textFields["loginTextField"].firstMatch
        passwordTextField = loginViewController.secureTextFields["passwordTextField"].firstMatch
        loginButton = loginViewController.buttons["loginButton"].firstMatch
        registrationButton = loginViewController.buttons["registrationButton"].firstMatch
    }

    override func tearDownWithError() throws {}
    
    func testLoginViewControllerCheckItems() throws {
        XCTAssertTrue(loginTextField.exists)
        XCTAssertTrue(passwordTextField.exists)
        XCTAssertTrue(loginButton.exists)
        XCTAssertTrue(registrationButton.exists)
    }
    
    func testLoginViewControllerAuth() throws {
        loginTextField.tap()
        loginTextField.typeText("login")
        passwordTextField.tap()
        passwordTextField.typeText("password")
        loginButton.tap()
        let catalogViewController = app.otherElements["CatalogViewController"]
        XCTAssertTrue(catalogViewController.waitForExistence(timeout: 5))
    }
    
    func testLoginViewControllerAuthFail() throws {
        passwordTextField.tap()
        passwordTextField.typeText("password")
        loginButton.tap()
        XCTAssert(app.alerts.element.staticTexts["Заполните поля логин и пароль."].exists)
    }
    
    func testLoginViewControllerRegistration() throws {
        registrationButton.tap()
        let registrationViewController = app.otherElements["RegistrationViewController"]
        XCTAssertTrue(registrationViewController.waitForExistence(timeout: 5))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
