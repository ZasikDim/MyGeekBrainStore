//
//  RegistrationViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 31.05.22.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cardTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    
    private var viewModel = RegistrationViewModel()
    private var gender: Gender = .male
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateViewWithMassage = { [unowned self] in
            guard let massage = viewModel.massage else { return }
            showAlert(massage: massage, performSegue: true)
        }
    }
    
    @IBAction func registrationButtonTapped(_ sender: Any) {
        checkFields()
    }
    
    @IBAction func genderControlChanged(_ sender: UISegmentedControl) {
        switch genderControl.selectedSegmentIndex {
        case 0:
            self.gender = .male
        case 1:
            self.gender = .female
        default:
            break
        }
    }
    
    private func checkFields() {
        if let name = nameTextField.text, !name.isEmpty,
           let password = passwordTextField.text, !password.isEmpty,
           let email = emailTextField.text, !email.isEmpty,
           let card = cardTextField.text, !card.isEmpty,
           let bio = infoTextField.text, !bio.isEmpty {
            viewModel.registration(username: name, password: password, email: email, gender: gender, creditCard: card, bio: bio)
        }
        else {
            showAlert(massage: "Заполните все поля.", performSegue: false)
        }
    }
    
    private func showAlert(massage: String, performSegue: Bool) {
        let alert = UIAlertController(title: nil, message: massage, preferredStyle: UIAlertController.Style.alert)
        
        switch performSegue.self {
        case true:
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                self.performSegue(withIdentifier: "fromRegistrationToLoginView", sender: self)
            }))
        case false:
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
