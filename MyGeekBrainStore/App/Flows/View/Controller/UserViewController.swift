//
//  UserViewController.swift
//  MyGeekBrainStore
//
//  Created by Dmitry Zasenko on 29.05.22.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var idLable: UILabel!
    @IBOutlet weak var loginLable: UILabel!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var lastNameLable: UILabel!
    @IBOutlet weak var genderLable: UILabel!
    @IBOutlet weak var creditCardLable: UILabel!
    @IBOutlet weak var bioLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    @IBAction func unwindFromChangeUserInfoView(unwindSegue: UIStoryboardSegue) {
        setView()
    }
    
    private func setView() {
        idLable.text = "id: \(User.shared.id)"
        loginLable.text = "@\(User.shared.login)"
        nameLable.text = User.shared.name
        lastNameLable.text = User.shared.lastname
        genderLable.text = User.shared.gender.rawValue
        creditCardLable.text = User.shared.creditCard
        bioLable.text = User.shared.bio
    }
}
