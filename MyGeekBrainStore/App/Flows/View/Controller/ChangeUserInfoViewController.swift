//
//  ChangeUserInfoViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 29.05.22.
//

import UIKit

final class ChangeUserInfoViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var creditCardTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var viewModel = ChangeUserInfoVM()
    private var gender: Gender = .male
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        checkFields()
    }
    
    @IBAction func changeGender(_ sender: UISegmentedControl) {
        switch genderControl.selectedSegmentIndex {
        case 0:
            self.gender = .male
        case 1:
            self.gender = .female
        default:
            break
        }
    }
    
    private func setFields() {
        nameTextField.text = User.shared.name
        passwordTextField.text = User.shared.lastname
        creditCardTextField.text = User.shared.creditCard
        infoTextField.text = User.shared.bio
        emailTextField.text = User.shared.email
        switch User.shared.gender {
        case .male:
            genderControl.selectedSegmentIndex = 0
        case.female:
            genderControl.selectedSegmentIndex = 1
        }

        viewModel.updateViewWithMassage = { [unowned self] in
            guard let massage = viewModel.massage else { return }
            showAlert(massage: massage, performSegue: true)
        }
    }
    private func checkFields() {
        if let name = nameTextField.text, !name.isEmpty,
           let password = passwordTextField.text, !password.isEmpty,
           let email = emailTextField.text, !email.isEmpty,
           let card = creditCardTextField.text, !card.isEmpty,
           let bio = infoTextField.text, !bio.isEmpty {
            viewModel.changeUserInfo(username: name, password: password, email: email, gender: gender, creditCard: card, bio: bio)
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
                self.performSegue(withIdentifier: "unwindFromChangeUserInfoViewWithUnwindSegue", sender: self)
            }))
        case false:
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
