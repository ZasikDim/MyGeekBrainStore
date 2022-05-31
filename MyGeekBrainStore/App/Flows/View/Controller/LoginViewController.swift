//
//  LoginViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 27.05.22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
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
            showAlert(text: "Заполните поля логин и пароль.")
        }
    }
    
    private func showAlert(text: String) {
        let alert = UIAlertController(title: "Ошибка входа", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
