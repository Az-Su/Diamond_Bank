//
//  LoginView.swift
//  Diamond_Bank
//
//  Created by Sailau Almaz Maratuly on 19.11.2022.
//

import Foundation
import UIKit

class LoginView: UIView, UITextFieldDelegate {
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    
    private let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 5
        clipsToBounds = true
        
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Add subviews and constraints

extension LoginView {
    func addSubviews() {
        
        loginStackView.addArrangedSubview(usernameTextField)
        loginStackView.addArrangedSubview(dividerView)
        loginStackView.addArrangedSubview(passwordTextField)
        addSubview(loginStackView)
        
    }
    
    func addConstraints() {
        // LoginView
        NSLayoutConstraint.activate([
            loginStackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            loginStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: loginStackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: loginStackView.bottomAnchor, multiplier: 1)
        ])
        
        // Divider between Username and Password
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}

// MARK: UITextFieldDelegate
extension LoginView {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
    }
    
}
