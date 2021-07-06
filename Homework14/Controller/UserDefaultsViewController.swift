//
//  UserDefaultsViewController.swift
//  Homework14
//
//  Created by Bagrat Arutyunov on 06.07.2021.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    private let nameTextField = UITextField()
    private let surnameTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        createTextField(field: nameTextField, placeholderText: "Name", top: 150, left: 30, right: -30, equalView: self.view)
        createTextField(field: surnameTextField, placeholderText: "Surname", top: 100, left: 30, right: -30, equalView: nameTextField)
        nameTextField.delegate = self
        surnameTextField.delegate = self
        nameTextField.text = UserDefaults.standard.string(forKey: UDKeys.nameKey)
        surnameTextField.text = UserDefaults.standard.string(forKey: UDKeys.surnameKey)
    }
    
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "UserDefaults"
    }
    
    func createTextField(field: UITextField, placeholderText: String?, top: CGFloat, left: CGFloat, right: CGFloat, equalView: UIView) {
        view.addSubview(field)
        field.textColor = .darkGray
        field.backgroundColor = .white
        field.translatesAutoresizingMaskIntoConstraints = false
        field.topAnchor.constraint(equalTo: view.topAnchor, constant: top).isActive = true
        field.leftAnchor.constraint(equalTo: view.leftAnchor, constant: left).isActive = true
        field.rightAnchor.constraint(equalTo: view.rightAnchor, constant: right).isActive = true
        field.placeholder = placeholderText ?? "Введите текст"
        field.layer.cornerRadius = 8
        field.textAlignment = .center
    }
    
}

extension UserDefaultsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        UserDefaultsPersistance.shared.nameUD = nameTextField.text
        UserDefaultsPersistance.shared.surnameUD = surnameTextField.text
    }
}
