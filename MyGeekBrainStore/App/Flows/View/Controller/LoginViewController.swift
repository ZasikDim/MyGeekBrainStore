//
//  LoginViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 27.05.22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    
    private let viewModel = LoginViewModel()
    private let reportExceptions = CrashlyticsReport()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.isAccessibilityElement = true
        loginTextField.accessibilityIdentifier = "loginTextField"
        
        passwordTextField.isAccessibilityElement = true
        passwordTextField.accessibilityIdentifier = "passwordTextField"
        
        loginButton.isAccessibilityElement = true
        loginButton.accessibilityIdentifier = "loginButton"
        
        registrationButton.isAccessibilityElement = true
        registrationButton.accessibilityIdentifier = "registrationButton"
        
        view.accessibilityIdentifier = "LoginViewController"
    }
    
    @IBAction func logInButtonTapped(_ sender: UIButton) {
        tryLogin()
    }
    
    @IBAction func unwindFromRegistrationView(unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "fromRegistrationToLoginView" else { return }
        let sourseVC = unwindSegue.source as! RegistrationViewController
        loginTextField.text = sourseVC.nameTextField.text ?? ""
        passwordTextField.text = sourseVC.passwordTextField.text ?? ""
        Basket.shared.items = []
    }
    
    @IBAction func unwindLogout(unwindSegue: UIStoryboardSegue) {
        loginTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func tryLogin() {
        if let login = loginTextField.text, !login.isEmpty, let password = passwordTextField.text, !password.isEmpty {
            viewModel.logIn(login: login, password: password) { [weak self] response in
                guard let self = self else { return }
                if response {
                    DispatchQueue.main.sync {
                        self.performSegue(withIdentifier: "toUserView", sender: self)
                    }
                }
            }
        }
        else {
            reportExceptions.reportWithUserInfo(userId: User.shared.id)
            showAlert(text: "Заполните поля логин и пароль.")
        }
    }
    
    private func showAlert(text: String) {
        let alert = UIAlertController(title: "Ошибка входа", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
